class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.user_id = current_user.id
    if @message.save
      redirect_to chat_path(@chat), notice: 'Message sent'
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
