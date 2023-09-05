class Message < ApplicationRecord
  has_one :pigeon
  belongs_to :chat
  belongs_to :sender, class_name: ‘User’, foreign_key: ‘sender_id’
end
