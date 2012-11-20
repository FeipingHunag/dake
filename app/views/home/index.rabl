object false

child @groups => :groups do
  extends "groups/base"
  node(:str_id) {|group| group.id.to_s}
end

child @following => :following do
  extends "users/base"
end

child @followers => :followers do
  extends "users/base"
end