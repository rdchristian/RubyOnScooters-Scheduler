json.array!(@resources) do |resource|
  json.extract! resource, :id, :name, :description, :numberOf, :storage_location, :max_reserve_time
  json.url resource_url(resource, format: :json)
end
