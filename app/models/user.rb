class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :chats
  has_many :messages
  has_many :pigeons
  has_one_attached :avatar

  # validates :email, presence: true
  # validates :avatar, attached: true
  # validates :avatar, attached: true, content_type: 'image/png'

  # validates :photos, attached: true, content_type: ['image/png', 'image/jpeg']

  # validates :image, attached: true,
  #           processable_image: true,
  #           content_type: ['image/png', 'image/jpeg']
end
