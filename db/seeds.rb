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
puts "Messages created"
pig1 = Pigeon.new(summary: "something something", message: message1, length: 10,
                      link_to_content: "https://www.youtube.com/watch?v=HuiIZzdG7EI&list=RDHuiIZzdG7EI&start_radio=1",
                      media_type: "video", date: Date.today, title: "AlunaGeorge - Not above Love",
                      description: "description")
pig1.tag_names << "Ukhouse"
pig1.tag_names << "Chill"
pig1.save
puts "Created: #{pig1.title}"

pig2 = Pigeon.new(summary: "something something", message: message2, length: 10,
              link_to_content: "https://www.theguardian.com/politics/2023/sep/06/gerry-bermingham-obituary",
              media_type: "article", date: Date.today, title: "North Korea Finds New Leverage in the Ukraine War",
              description: "description")
pig2.tag_names << "World"
pig2.tag_names << "Politics"
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

pig4 = Pigeon.new(summary: "something something", message: message4, length: 125,
              link_to_content: "https://open.spotify.com/episode/6ybdcNPGRMRIYTwXnLVE9w?si=36335912ed7949ac",
              media_type: "podcast", date: Date.today, title: "Bill maher on JRE",
              description: "description")
pig4.tag_names << "Misc"
pig4.tag_names << "Politics"
pig4.save
puts "Created: #{pig4.title}"

pig5 = Pigeon.new(summary: "something something", message: message5, length: 73,
              link_to_content: "https://open.spotify.com/episode/4VEeWbuY6zHfY5f5nEvsxS?si=df54bba67d324915",
              media_type: "podcast", date: Date.today, title: "The Meandering Route To Success",
              description: "description", read: true)
pig5.tag_names << "Funny"
pig5.tag_names << "Comedy"
pig5.save
puts "Created: #{pig5.title}"
puts "Pigeons created"

https://open.spotify.com/show/4W9G20JohHbFX7qArG32Bn?si=67b0d30678db4822
