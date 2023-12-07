class Label < ApplicationRecord
  belongs_to :pigeon
  belongs_to :content_category, dependent: :destroy
end
