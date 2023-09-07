class Pigeon < ApplicationRecord
  has_many :content_categories, through: :labels
  belongs_to :message
  has_many :taggings, as: :taggable, class_name: 'Gutentag::Tagging'
  has_many :tags, through: :taggings, class_name: 'Gutentag::Tag'

  Gutentag::ActiveRecord.call self

  def self.ransackable_attributes(auth_object = nil)
    ["tag_names"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["tag_names"]
  end
end
