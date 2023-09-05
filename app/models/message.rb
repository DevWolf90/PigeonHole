class Message < ApplicationRecord
  has_one :pigeon
  belongs_to :chat
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"

  after_create_commit -> {
    broadcast_append_to "chat_#{chat.id}", target: "messages", partial: "messages/message", locals: { message: self }
  }

end
