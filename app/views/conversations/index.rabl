collection @conversations

attributes :unread_count
child(:friend => :friend) do
  extends 'users/base'
end

child(:last_message => :last_message) do
  extends 'messages/base'
end