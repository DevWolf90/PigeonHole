require "open-uri"
require "nokogiri"

url = "https://medium.com/@karen_olson/creating-multiple-user-types-with-a-one-to-many-relationship-in-rails-ba3bbe4b0a8a"

html_file = URI.open(url).read
html_doc = Nokogiri::HTML.parse(html_file)
puts html_doc.at("body").text

OpenaiService.new("How long would it take to read this text? #{html_doc.at("body").text}").call
