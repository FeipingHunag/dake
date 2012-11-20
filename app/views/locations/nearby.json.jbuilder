json.(@users) do |json, user|
  json.(user, :id, :name)
  json.distance user.distance
end