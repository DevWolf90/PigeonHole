class Message < ApplicationRecord
  has_one :pigeon
  belongs_to :chat
  belongs_to :sender, class_name: "User", foreign_key: "user_id"
  # belongs_to :recipient, class_name: "User", foreign_key: "user_id"

  after_create_commit -> {
    broadcast_append_to chat, target: "messages", partial: "messages/message", locals: { message: self }
  }

end
