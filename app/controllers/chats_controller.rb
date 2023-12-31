class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    @pigeons = Pigeon.where(chat_id: @chat)
    @chats = Chat.where(sender: current_user).or(Chat.where(recipient: current_user))
    @current_user = current_user
    @chatting_partner = @chat.recipient
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)

    if @chat.save
      redirect_to @chat, notice: "Chat was successfully sent."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @chats = Chat.where(sender: current_user).or(Chat.where(recipient: current_user)).order(created_at: :desc)
  end
end
