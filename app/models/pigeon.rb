class Pigeon < ApplicationRecord
  has_many :labels, dependent: :destroy
  has_many :content_categories, through: :labels
  belongs_to :chat
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"
  belongs_to :user
  # has_many :taggings, as: :taggable, class_name: 'Gutentag::Tagging'
  # has_many :tags, through: :taggings, class_name: 'Gutentag::Tag'
  before_save :summarize_url, if: :link_to_content_changed?
  attr_accessor :custom_tags

  # Gutentag::ActiveRecord.call self

  # def self.ransackable_attributes(auth_object = nil)
  #   ["tag_names"]
  # end

  # def self.ransackable_associations(auth_object = nil)
  #   ["tag_names"]
  # end

  def summarize_url
    self.summary = OpenaiService.new(link_to_content, 2).call
  end

  # def summarize_url
  #   THIS REMOVES LINKS FROM TEXT
  #   content_without_links = link_to_content.gsub(/https?:\/\/[^\s]+/, '')

  #   # Call the OpenAI service to generate the summary
  #   self.summary = OpenaiService.new(content_without_links, 2).call

  #   # Limit the summary to 180 characters, WE CAN CHANGE LIMIT. IM JUST NOT SURE WHAT LIMIT WE WANT
  #   self.summary = self.summary[0, 180] if self.summary.length > 180
  # end


  def fetch_video_duration
    return unless link_to_content.match?('youtube.com')
    video_id = extract_video_id
    api_key = ENV['YOUTUBE_API']
    base_url = "https://www.googleapis.com/youtube/v3/videos?id=#{video_id}&key=#{api_key}&part=contentDetails"
    response = JSON.parse(Net::HTTP.get(URI(base_url)))
    duration = response['items'].first['contentDetails']['duration']
    if duration.match?(/\d+M/)
      duration_match = duration.match(/\d+M/)[0]
      # Save the duration or do whatever you want with it
      self.length = duration_match.to_i
    end
  end

  def extract_video_id
    # Regular expression to extract video ID from a standard YouTube URL
    link_to_content.match(/v=(\w+)/)[1]
  end
end
