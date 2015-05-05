json.array!(@events) do |event|
  json.extract! event, :id, :title, :description, :start, :ending, :duration, :facility_ids, :resource_ids, :creator_name
  json.url event_url(event, format: :json)
end
