object false

child @groups => :groups do
  extends "groups/base"
end

child @following => :following do
  extends "users/base"
end

child @followers => :followers do
  extends "users/base"
end