class Pigeon < ApplicationRecord
  has_many :content_categories, through: :labels
  belongs_to :chat
  has_many :taggings, as: :taggable, class_name: 'Gutentag::Tagging'
  has_many :tags, through: :taggings, class_name: 'Gutentag::Tag'

  before_save :summarize_url, if: :link_to_content_changed?

  Gutentag::ActiveRecord.call self

  def self.ransackable_attributes(auth_object = nil)
    ["tag_names"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["tag_names"]
  end

  def summarize_url
    self.summary = OpenaiService.new(link_to_content, 2).call
  end
end
