class Message < ApplicationRecord
  has_one :pigeon
  belongs_to :chat
  #belongs_to :user, class_name: "User", foreign_key: "sender_id"
  belongs_to :sender, class_name: "User", foreign_key: "user_id"

  after_create_commit -> {
    broadcast_append_to chat, target: "messages", partial: "messages/message", locals: { message: self }
  }

end
