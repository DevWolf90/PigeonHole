class ContentCategory < ApplicationRecord
  has_many :pigeons, through: :labels, dependent: :destroy
end
