class UsersController < ApplicationController
validates :email, presence: true
validates :avatar, attached: true
validates :avatar, attached: true, content_type: 'image/png'

validates :photos, attached: true, content_type: ['image/png', 'image/jpeg']

validates :image, attached: true,
            processable_image: true,
            content_type: ['image/png', 'image/jpeg']
end
