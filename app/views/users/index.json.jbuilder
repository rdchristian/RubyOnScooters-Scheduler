json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :password_digest, :phone, :home_group
  json.url user_url(user, format: :json)
end
