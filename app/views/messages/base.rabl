attributes :id, :nickname, :bio
child :user do
  extends 'users/base'
end