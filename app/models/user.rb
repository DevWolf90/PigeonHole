class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :chats
  has_many :messages
  has_many :pigeons
  has_one_attached :avatar
  validates :nickname, presence: true
end
