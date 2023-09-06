require "json"
require "open-uri"

url = " https://www.googleapis.com/youtube/v3/videos?id=7lCDEYXw3mM&key=AIzaSyAGctSGiMynyAje1Qao7e9oURMDcwBaGOo
&part=snippet,statistics"
user_serialized = URI.open(url).read
user = JSON.parse(user_serialized)

puts user
