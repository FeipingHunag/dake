json.(@users) do |json, user|
  json.(user, :id, :nickname, :age, :gender, :bio)
  json.distance user.distance
  json.located_at Time.parse(user.located_at).to_i
end