require "json"
require "open-uri"

url = "https://www.googleapis.com/youtube/v3/videos?id=7lCDEYXw3mM&key=AIzaSyAGctSGiMynyAje1Qao7e9oURMDcwBaGOo
&part=snippet,statistics"
user_serialized = URI.open(url).read
user = JSON.parse(user_serialized)

url2 = 'https://youtube.googleapis.com/youtube/v3/captions/AUieDaZHoNpK02ujL8Q3ra9ool42D4J1DtIX3gKSgPoH?key=AIzaSyAGctSGiMynyAje1Qao7e9oURMDcwBaGOo'
captions = URI.open(url2).read
cap = JSON.parse(captions)

puts user
puts cap
