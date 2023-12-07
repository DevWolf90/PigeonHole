class ContentCategory < ApplicationRecord
  has_many :pigeons, through: :labels, dependent: :destroy
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
end
