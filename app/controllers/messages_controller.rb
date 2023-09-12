class MessagesController < ApplicationController
  before_action :set_chat
  include ActionView::Helpers::UrlHelper

  def create
    # @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.sender = current_user
    if @message.save
      flash[:notice] = "Message successfully sent"
      if current_page?(chat_path(@chat))
        redirect_to chat_path(@chat)
      else
        redirect_back(fallback_location: root_path)
      end
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
