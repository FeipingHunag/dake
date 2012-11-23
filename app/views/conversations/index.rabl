collection @conversations

attributes :unread_count
child(:friend) do
  extends 'users/base'
end

child(:last_message) do
  extends 'messages/base'
end