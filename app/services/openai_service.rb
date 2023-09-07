# app/services/openai_service.rb
class OpenaiService
  attr_reader :client, :prompt

  def initialize(article_url, sentences = 3)
    @article_url = article_url
    @sentences = sentences
  end

  def call
    url = 'http://api.meaningcloud.com/summarization-1.0'
    sentences = 5

    response = HTTParty.post(url,
      body: {
        key: ENV['SUMMARIZATION_API_KEY'],
        url: @article_url,
        sentences: @sentences
      })

      res = JSON.parse(response.body)

      # {"status"=>{"code"=>"212", "msg"=>"no content to analyze", "credits"=>"0"}}
      if res["summary"]
        return res["summary"]
      else
        return "Summary failed: #{res["status"]["message"]}"
      end
  end
end
