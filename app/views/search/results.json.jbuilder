json.array!(@facilities_results) do |facility|
	json.extract! facility, :id, :name
	json.url facility_url(facility, format: :json)
end

json.array!(@resources_results) fo |resource|
	json.extract! resource, :id, :name
	json.url resource_url(resource, format: :json)
end