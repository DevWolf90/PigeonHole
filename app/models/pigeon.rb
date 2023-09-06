class Pigeon < ApplicationRecord
  has_many :content_categories, through: :labels
  belongs_to :message
  Gutentag::ActiveRecord.call self
  def self.ransackable_attributes(auth_object = nil)
    super + %w[tag_names]
  end

  end
end
