json.(@users) do |json, user|
  json.(user, :id, :nickname, :age, :gender)
  json.distance user.distance
  json.located_at user.located_at
end