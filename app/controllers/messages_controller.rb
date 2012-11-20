class MessagesController < ApplicationController
  before_filter :get_message, except: [:create]

  # @param [(group_id | user_id), message: [content, mtype] ]
  def create
    to = Group.find(params[:group_id]) if params[:group_id]
    to = User.find(params[:user_id]) if params[:user_id]
    @message = current_user.send_message_to(to, message_params)
  end

  def read
    @message.make_as_read
    render nothing: true
  end

  def destroy
    current_user.delete_message @message
    render nothing: true
  end

  private
  def get_message
    @message = Message.find params[:id]
  end

  def message_params
    params.require(:message).permit(:content, :mtype)
  end
end
