#!/usr/bin/ruby
# @Author: Synix
# @Date:   2015-05-04 04:01:32
# @Last Modified by:   Synix
# @Last Modified time: 2015-05-06 21:10:14

class Search

  # Search capped offset from start or end time if they are not given [now - cap, now + cap]
  def self.limit
    3.months
  end

  def self.events(params = {})
    query   = Event
    if params[:start] and params[:end]
      query_a = query.overlapping_events_to_a(params[:start], params[:end])
    else
      params[:start] = Time.zone.now - Search.limit if params[:start].blank?
      params[:end] = Time.zone.now + Search.limit if params[:end].blank?
      query_a = query.all
    end
    # For now, multiple resource conditions are OR'ed, and facilities and resources are AND'ed
    # E.g. Look for Events that have (chairs OR pencils) AND are in a classroom
    # & is Array intersection (common elements)
    query_a = query_a.select { |event| (event.resources.ids & params[:resources]).present? } if params[:resources]
    query_a = query_a.select { |event| (event.facilities.ids & params[:facilities]).present? } if params[:facilities]

    results = []
    query_a.each do |event|
      if event.recurrence.blank?
        results << [event, event.start]
      else
        results += event.recurrence.
                         occurrences_between(params[:start], params[:end]).
                         collect{ |t| [event, t] }
      end
    end
    return results
  end

  # This function returns exceptions to the given search criteria, because by default you can schedule
  # a resource at any time UNLESS there's a conflict.
  def self.resources(params = {})
    query   = Event
    # Find events associated with a resource name
    resource_ids = []
    if params[:name]
      query   = query.joins(:resources).where("lower(resources.name) LIKE ?", "%#{params[:name].downcase}%")
      resource_ids = query.select('resources.id as id').uniq.collect(&:id) # Watch out, 'ids' might not work here
    end
    Rails.logger.info(query)
    # that cross the given time frame
    if params[:start] and params[:end]
      query_a = query.overlapping_events_to_a(params[:start], params[:end])
    else
      params[:start] = Time.zone.now - Search.limit if params[:start].blank?
      params[:end] = Time.zone.now + Search.limit if params[:end].blank?
      query_a = query.all
    end
    Rails.logger.info([params, query_a, resource_ids])
    # See if they leave any resources for us to take
    exceptions = []
    query_a.each do |event|
      Rails.logger.info(exceptions)
      common_resources = resource_ids & event.resources.ids
      if event.recurrence.present?
        event.recurrence.
          occurrences_between(params[:start], params[:end]).each do |t|
            t = t.to_time
            exceptions << [event, t] if 
              common_resources.any? do |res_id|
                event.num_of_resource_reserved_at_time(res_id, t, t + event.recurrence.duration) + 
                  params[:numberOf] > Resource.find(res_id).numberOf
              end
          end #occurrences

      else # no recurrence
        exceptions << [event, event.start] if
          common_resources.any? do |res_id|
            event.num_of_resource_reserved_at_my_time(res_id) + params[:numberOf] > Resource.find(res_id).numberOf
          end
      end
    end
    Rails.logger.info(exceptions)
    return exceptions
  end

  def self.facilities(params = {})
    query   = Event
    query   = query.where('capacity >= ?', params[:capacity]) if params[:capacity]
    # Find events associated with a facility name
    facility_ids = []
    if params[:name]
      query   = query.joins(:facilities).where("lower(facilities.name) LIKE ?", "%#{params[:name].downcase}%")
      facility_ids = query.select('facilities.id as id').uniq.collect(&:id) # Watch out, 'ids' might not work here
    end
    # that cross the given time frame
    if params[:start] and params[:end]
      query_a = query.overlapping_events_to_a(params[:start], params[:end])
    else
      params[:start] = Time.zone.now - Search.limit if params[:start].blank?
      params[:end] = Time.zone.now + Search.limit if params[:end].blank?
      query_a = query.all
    end

    # See if they leave any facilities for us to take
    exceptions = []
    query_a.each do |event|
      if (facility_ids & event.facilities.ids).present?
        if event.recurrence.present?
          exceptions += event.recurrence.
                              occurrences_between(params[:start], params[:end]).
                              collect{ |t| [event, t] } 
        else
          exceptions << [event, event.start]
        end
      end
    end
    return exceptions
  end

end