class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :chats
  has_many :messages
  has_many :pigeons
  has_many :owned_content_categories, class_name: 'ContentCategory', foreign_key: 'owner_id'
  has_many :created_content_categories, class_name: 'ContentCategory', foreign_key: 'creator_id'
  has_one_attached :avatar
  validates :nickname, presence: true
end
