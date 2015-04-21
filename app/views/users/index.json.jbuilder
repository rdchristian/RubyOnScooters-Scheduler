json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :password_digest, :phone, :home_group, :user_level
  json.url user_url(user, format: :json)
end
