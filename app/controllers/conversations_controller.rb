class ConversationsController < ApplicationController
  def index
    
  end

  def show
    friend = User.find params[:id]
    @messages = Message.connected_with current_user, friend
  end
end
