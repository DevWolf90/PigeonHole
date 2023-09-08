class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    @pigeons = Pigeon.where(chat_id: @chat)
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
end
