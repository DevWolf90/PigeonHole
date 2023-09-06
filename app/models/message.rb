class Message < ApplicationRecord
  has_one :pigeon
  belongs_to :chat
  belongs_to :user, class_name: "User", foreign_key: "sender_id"
end
