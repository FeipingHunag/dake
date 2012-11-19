object @user

attributes :id, :authentication_token, :email, :nickname

child :groups do
  extends "groups/base"
end