class ConversationsController < ApplicationController
  def index
    @conversations = current_user.conversations.includes(:last_message).not_blank
  end

  def show
    @friend = User.find params[:id]
    @messages = Message.includes(:user).connected_with(current_user, @friend)

    Conversation.connected_with(current_user.id, @friend.id).update_all(unread_count: 0)
  end
end
