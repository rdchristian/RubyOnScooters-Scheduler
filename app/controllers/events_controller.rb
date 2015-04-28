include IceCube
require 'json'

class EventsController < ApplicationController
  before_filter :authenticate_user!
  before_action :correct_user!
  before_action :determine_scope
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /users/:id/events
  # GET /users/:id/events.json
  # GET /events
  # GET /events.json
  def index
    @events = @scope.all
  end

  # GET /users/:id/events/:id
  # GET /users/:id/events/:id.json
  def show
  end

  # GET /users/:id/events/new
  def new
    @event = @scope.new
  end

  # GET /users/:id/events/:id/edit
  def edit
  end

  # POST /users/:id/events
  # POST /users/:id/events.json
  def create
    @event = @scope.new(event_params)
    if !@event.capacity_check || !@event.facility_priority_check
      @event.approved = false
    end
    respond_to do |format|
      if @event.save
        if @event.is_approved?
          format.html { redirect_to ([@event.creator, @event]), notice: 'Event was successfully created.' }
        else 
          format.html { redirect_to ([@event.creator, @event]), notice: 'Your event will be reviewed by an administrator and you will receive an email when it is approved or denied.' }
        end
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/:id/events/:id
  # PATCH/PUT /users/:id/events/:id.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to ([@event.creator, @event]), notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/:id/events/:id
  # DELETE /users/:id/events/:id.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully removed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = @scope.find(params[:id])
    end

    def correct_user?
      is_admin? or current_user.id == params[:user_id].to_i
    end

    def correct_user!
      redirect_to root_url if params[:user_id] and not correct_user?
    end

    def determine_scope
      @scope = if params[:user_id]
        (correct_user? ? User.find(params[:user_id]) : current_user).events
      else
        is_admin? ? Event : current_user.events
      end
    end

    def approve
      set_event
      @event.approved = true;
      @event.save!
      redirect_to admin_path
    end

    def check_in
      set_event
      @event.checked_in = true;
      @event.save!
      redirect_to ""
    end

    helper_method :format_fields
    def format_fields
      # Datetime formatting
      params[:duration] = @event.duration.strftime("%I:%M") if @event.duration
      params[:start_time] = @event.start.strftime("%I:%M %p") if @event.start
      params[:start_date] = @event.start.strftime("%B %e, %Y") if @event.start
      params[:ending] = @event.ending.strftime("%B %e, %Y, %I:%M %p") if @event.ending

      # Recurrence
      params[:recurrence_checked] = false
      params[:recurring_value] = 1
      params[:recurring_option] = 0
      if @event.recurrence.present?
        params[:recurrence_checked] = true
        rule = @event.recurrence.to_hash[:rrules][0]
        params[:recurring_value] = rule[:interval]
        params[:recurring_option] = Event.recurrence_options.find_index { |k| rule[:rule_type].scan(k[0..1]).present? }
      end

      # Count of each resource
      params[:resource_counts] = @event.resource_counts.to_json if @event.resource_counts
    end

    def event_params
      form = params[:event]
      # Setting the proper :start and :ending values
      if form[:start].is_a? String
        date, time = form[:start_date], form[:start]
        form[:start] = Time.zone.parse(date + ' ' + time).to_datetime

        duration = form[:duration].to_time
        form[:ending] = form[:start].advance({:hours => duration.hour, :minutes => duration.min})
      end

      # Setting up the recurrence
      if params[:recurrence_checked]
        option = Event.recurrence_options[params[:recurring_option].to_i]
        rule = Event.get_recurrence_rule(option)

        schedule = Schedule.new(form[:start])
        schedule.add_recurrence_rule rule.call(params[:recurring_value].to_i)
        form[:recurrence] = schedule
      else
        form[:recurrence] = nil
      end

      # Setting up resource_counts
      footlog(form, JSON.parse(form[:resource_counts]))
      form[:resource_counts] = JSON.parse(form[:resource_counts])

      # Strong parameters
      # Never trust parameters from the scary internet, only allow the white list through.
      params.require(:event).permit(:title, :description, :start, :start_date, :duration, :recurrence, :resource_counts,
                                    :attendees, :memo, :creator_name, resource_ids: [], facility_ids: [])
      # Because recurrence is an object, we have to go through this bullshit to permit all its hash fields
      params.require(:event).tap do |whitelisted|
        whitelisted[:recurrence] = params[:event][:recurrence]
        whitelisted[:resource_counts] = params[:event][:resource_counts]
      end

    end # private

end
