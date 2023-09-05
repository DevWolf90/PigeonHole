class Chat < ApplicationRecord
  belongs_to :sender, class_name: ‘User’, foreign_key: ‘sender_id’
  belongs_to :recipient, class_name: ‘User’, foreign_key: ‘receiver_id’
  has_many :messages
end
