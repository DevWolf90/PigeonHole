class MessagesController < ApplicationController
  before_action :set_chat
  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.sender = current_user
    if @message.save
      flash[:notice] = "Message successfully sent"
      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  def new
    @message = Message.new
    @pigeon = Pigeon.new
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
