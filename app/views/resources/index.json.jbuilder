json.array!(@resources) do |resource|
  json.extract! resource, :id, :name, :description, :numberOf
  json.url resource_url(resource, format: :json)
end
