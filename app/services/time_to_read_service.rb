# app/services/openai_service.rb

require 'open-uri'
require 'nokogiri'

class TimeToReadService
  def initialize(article_url)
    @article_url = article_url
    # @openai_client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])
  end

  def call
    html_string = URI.open(@article_url).read
    noko_doc = Nokogiri::HTML.parse(html_string)
    # response = @openai_client.completions(
    #   parameters: {
    #       model: "text-davinci-001",
    #       prompt: "How many minutes would it take to read this text: #{html_string}",
    #       max_tokens: 2000
    #   })
    total_text = ""
    noko_doc.traverse{ |x|
      if x.text? && x.text !~ /^\s*$/
          total_text += "#{x.text} "
      end
    }
    word_count = total_text.split.size
    avg_words_per_min = 238
    minutes =  word_count.fdiv(avg_words_per_min)
    return minutes.ceil # ceil to round up
  end
end
