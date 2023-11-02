# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)t
Pigeon.delete_all
Message.delete_all
Chat.delete_all
User.delete_all
puts "Database cleared"

yustiniya = User.create(email: "yustiniya@pigeonhole.digital", password: "yustiniya@pigeonhole.digital", nickname: "DevWolf90")
sara = User.create(email: "sara@pigeonhole.digital", password: "sara@pigeonhole.digital", nickname: "SaraLuisM")
duarte = User.create(email: "duarte@pigeonhole.digital", password: "duarte@pigeonhole.digital", nickname: "duartempmartins")
jode = User.create(email: "jode@pigeonhole.digital", password: "jode@pigeonhole.digital", nickname: "MadeMartian")
elias = User.create(email: "elias@pigeonhole.digital", password: "elias@pigeonhole.digital", nickname: "eho008")
puts "Users created"

chat1 = Chat.create(sender: yustiniya, recipient: sara)
chat2 = Chat.create(sender: duarte, recipient: jode)
chat3 = Chat.create(sender: elias, recipient: yustiniya)
chat4 = Chat.create(sender: sara, recipient: duarte)
chat5 = Chat.create(sender: jode, recipient: elias)
chat6 = Chat.create(sender: yustiniya, recipient: duarte)
chat7 = Chat.create(sender: yustiniya, recipient: jode)

puts "Chats created"

Message.create(content: "Hello", date: Date.today, chat: chat1, sender: yustiniya)
message1 = Message.create(content: "Check out what i found on YT", date: Date.today, chat: chat1, sender: yustiniya)
Message.create(content: "Hello", date: Date.today, chat: chat2, sender: duarte)
message2 = Message.create(content: "I really enjoyed this article", date: Date.today, chat: chat2, sender: duarte)
Message.create(content: "Hey there", date: Date.today, chat: chat3, sender: elias)
message3 = Message.create(content: "I really enjoyed this book", date: Date.today, chat: chat3, sender: elias)
Message.create(content: "Hey there", date: Date.today, chat: chat4, sender: sara)
message4 = Message.create(content: "Check out this amazing podcast episode from JRE", date: Date.today, chat: chat4, sender: sara)
Message.create(content: "Whats Up?", date: Date.today, chat: chat5, sender: jode)
message5 = Message.create(content: "this Netflix movie blew my mind", date: Date.today, chat: chat5, sender: jode)
Message.create(content: "Whats Up?", date: Date.today, chat: chat6, sender: duarte)
Message.create(content: "Whats Up?", date: Date.today, chat: chat7, sender: jode)

puts "Messages created"

puts "Creating content categories"
cat1 = ContentCategory.new(name: "music", creator_id: yustiniya.id)
cat1.save
cat2 = ContentCategory.new(name: "politics", creator_id: yustiniya.id)
cat2.save
cat3 = ContentCategory.new(name: "art", creator_id: yustiniya.id)
cat3.save
cat4 = ContentCategory.new(name: "football", creator_id: jode.id)
cat4.save
cat5 = ContentCategory.new(name: "programming", creator_id: jode.id)
cat5.save
cat6 = ContentCategory.new(name: "movies", creator_id: jode.id)
cat6.save

puts "Created content categories"

puts "Creating pigeons"

pig1 = Pigeon.new(summary: "something something", chat:chat1, length: 10, user:jode,
                      link_to_content: "https://www.bbc.co.uk/news/science-environment-24021772",
                      media_type: "article", date: Date.today, title: "What is climate change?",
                      description: "description", recipient: sara)
pig1.content_categories << cat5
pig1.content_categories << cat6
pig1.save
puts "Created: #{pig1.title}"

pig2 = Pigeon.new(summary: "something something", chat: chat2, length: 10, user:jode,
              link_to_content: "https://www.theguardian.com/politics/2023/sep/06/gerry-bermingham-obituary",
              media_type: "article", date: Date.today, title: "North Korea Finds New Leverage in the Ukraine War",
              description: "description", recipient: jode)
pig2.content_categories << cat1
pig2.content_categories << cat2
pig2.save
puts "Created: #{pig2.title}"

# pig3 = Pigeon.new(summary: "something something", message: message3, length: 5000,
#               link_to_content: "https://www.epedagogia.com.br/materialbibliotecaonine/797The-Count-of-Monte-Cristo.pdf",
#               media_type: "book", date: Date.today, title: "The count of montecristo",
#               description: "description", favourite: true)
# pig3.tag_names << "Classic"
# pig3.tag_names << "Novel"
# pig3.save
# puts "Created: #{pig3.title}"

pig4 = Pigeon.new(summary: "something something", chat: chat4, length: 125, user:jode,              link_to_content: "https://open.spotify.com/episode/6ybdcNPGRMRIYTwXnLVE9w?si=36335912ed7949ac",
              media_type: "podcast", date: Date.today, title: "Bill maher on JRE",
              description: "description", recipient: duarte)
pig4.content_categories << cat3
pig4.content_categories << cat4
pig4.save
puts "Created: #{pig4.title}"

pig5 = Pigeon.new(summary: "something something", chat: chat5, length: 73, user:jode,              link_to_content: "https://www.bicycling.com/repair/g20032398/how-to-do-these-five-common-bicycle-repairs/",
              media_type: "Tutorial", date: Date.today, title: "How to fix a bike🚲",
              description: "description", read: true, recipient: elias)
pig5.content_categories << cat3
pig5.content_categories << cat5
pig5.save
puts "Created: #{pig5.title}"
puts "Pigeons created"

pig6 = Pigeon.new(summary: "something something", chat: chat6, length: 21, user:jode,
  link_to_content: "https://open.spotify.com/episode/1cEZDjanhbQwusJPtv0ngB",
  media_type: "podcast", date: Date.today, title: "Would You like a selfie?",
  description: "description", recipient: yustiniya)
pig6.content_categories << cat4
pig6.content_categories << cat5
pig6.save
puts "Created: #{pig6.title}"
puts "Pigeons created"

pig7 = Pigeon.new(summary: "something something", chat: chat7, length: 60, user:jode,              link_to_content: "https://open.spotify.com/show/3gaGfrqgnVqUBNDdtv5p3S",
              media_type: "podcast", date: Date.today, title: "Bad Friends",
              description: "description", recipient: yustiniya)
pig7.content_categories << cat3
pig7.content_categories << cat4
pig7.save
puts "Created: #{pig7.title}"
puts "Pigeons created"

pig8 = Pigeon.new(summary: "something something", chat: chat7, length: 15, user:jode,
  link_to_content: "https://www.theguardian.com/environment/2023/sep/08/biggest-clean-energy-disaster-in-years-uk-auction-secures-no-offshore-windfarms",
  media_type: "article", date: Date.today, title: "Biggest clean energy disaster in years",
  description: "description", recipient: yustiniya)
pig8.content_categories << cat2
pig8.content_categories << cat4
pig8.save
puts "Created: #{pig8.title}"
puts "Pigeons created"

pig9 = Pigeon.new(summary: "something something", chat: chat3, length: 20, user:jode,
  link_to_content: "https://www.theguardian.com/commentisfree/2023/sep/07/britain-brexit-eu-horizon-programme-science",
  media_type: "article", date: Date.today, title: "Britain can recover from the self-harm of Brexit",
  description: "description", recipient: yustiniya)
pig9.content_categories << cat5
pig9.content_categories << cat2
pig9.save
puts "Created: #{pig9.title}"
puts "Pigeons created"

pig10 = Pigeon.new(summary: "something something", chat: chat4, length: 30, user:jode,
  link_to_content: "https://open.spotify.com/episode/2T757nicqi1eoefOefrtqK",
  media_type: "podcast", date: Date.today, title: "Trump surrenders to Georgia authorities",
  description: "description", recipient: yustiniya)
pig10.content_categories << cat1
pig10.content_categories << cat4
pig10.save
puts "Created: #{pig10.title}"

pig11 = Pigeon.new(summary: "something something", chat:chat1, length: 3, user:jode,
  link_to_content: "https://www.youtube.com/watch?v=OAM1qPeYyM4&list=RDOAM1qPeYyM4&start_radio=1",
  media_type: "video", date: Date.today, title: "Chillout Lounge",
  description: "description", recipient: yustiniya)
pig11.content_categories << cat2
pig11.content_categories << cat5
pig11.save
puts "Created: #{pig11.title}"

pig12 = Pigeon.new(summary: "something something", chat: chat6, length: 28, user:jode,
  link_to_content: "https://open.spotify.com/show/2yh3hbULLIewV87rTogCdR",
  media_type: "podcast", date: Date.today, title: "World Business Report",
  description: "description", recipient: yustiniya)
pig12.content_categories << cat1
pig12.save
puts "Created: #{pig12.title}"
puts "Pigeons created"

pig13 = Pigeon.new(summary: "something something", chat:chat1, length: 4, user:jode,
  link_to_content: "https://www.youtube.com/watch?v=LrLUuiFxYL4",
  media_type: "video", date: Date.today, title: "Fell Good Acoustic",
  description: "description", recipient: yustiniya)
pig13.content_categories << cat1
pig13.save
puts "Created: #{pig13.title}"

pig14 = Pigeon.new(summary: "something something", chat:chat1, length: 9, user:jode,
  link_to_content: "https://www.youtube.com/watch?v=h_D3VFfhvs4",
  media_type: "song", date: Date.today, title: "Micheal Jackson - Smooth Criminal",
  description: "description", recipient: duarte)
pig14.content_categories << cat4
pig14.save
puts "Created: #{pig14.title}"
