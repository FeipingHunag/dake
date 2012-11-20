attributes :id, :mtype, :content, :created_at

child :user do
  extends 'users/base'
end