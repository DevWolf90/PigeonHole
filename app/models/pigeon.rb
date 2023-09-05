class Pigeon < ApplicationRecord
  has_many :content_categories, through: :labels
  belongs_to :message
end
