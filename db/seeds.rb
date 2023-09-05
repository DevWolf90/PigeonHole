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

yustinia = User.create(email: "yustinia@pigeonhole.digital", encrypted_password: "yustinia@pigeonhole.digital", nickname: "DevWolf90")
sara = User.create(email: "sara@pigeonhole.digital", encrypted_password: "sara@pigeonhole.digital", nickname: "SaraLuisM")
duarte = User.create(email: "duarte@pigeonhole.digital", encrypted_password: "duarte@pigeonhole.digital", nickname: "duartempmartins")
jode = User.create(email: "jode@pigeonhole.digital", encrypted_password: "jode@pigeonhole.digital", nickname: "MadeMartian")
elias = User.create(email: "elias@pigeonhole.digital", encrypted_password: "elias@pigeonhole.digital", nickname: "eho008")

chat1 = Chat.create(sender: yustinia, recipient: sara)
chat2 = Chat.create(sender: duarte, recipient: jode)
chat3 = Chat.create(sender: elias, recipient: yustinia)
chat4 = Chat.create(sender: sara, recipient: duarte)
chat5 = Chat.create(sender: jode, recipient: elias)

Message.create(content: "Hello", date: Date.today, chat: chat1, sender: yustinia)
message1 = Message.create(content: "Check out what i found on YT", date: Date.today, chat: chat1, sender: yustinia)
Message.create(content: "Hello", date: Date.today, chat: chat2, sender: duarte)
message2 = Message.create(content: "I really enjoyed this article", date: Date.today, chat: chat2, sender: duarte)
Message.create(content: "Hey there", date: Date.today, chat: chat3, sender: elias)
message3 = Message.create(content: "I really enjoyed this book", date: Date.today, chat: chat3, sender: elias)
Message.create(content: "Hey there", date: Date.today, chat: chat4, sender: sara)
message4 = Message.create(content: "Check out this amazing podcast episode from JRE", date: Date.today, chat: chat4, sender: sara)
Message.create(content: "Whats Up?", date: Date.today, chat: chat5, sender: jode)
message5 = Message.create(content: "this Netflix movie blew my mind", date: Date.today, chat: chat5, sender: jode)

Pigeon.create(summary: "something something", message: message1, length: 10,
              link_to_content: "https://www.youtube.com/watch?v=HuiIZzdG7EI&list=RDHuiIZzdG7EI&start_radio=1",
              media_type: "video", date: Date.today, title: "AlunaGeorge - Not above Love",
              description: "description")
Pigeon.create(summary: "something something", message: message2, length: 10,
              link_to_content: "https://www.nytimes.com/2023/09/05/world/asia/north-korea-russia-kim-jong-un.html",
              media_type: "article", date: Date.today, title: "North Korea Finds New Leverage in the Ukraine War",
              description: "description")
Pigeon.create(summary: "something something", message: message3, length: 5000,
              link_to_content: "https://www.epedagogia.com.br/materialbibliotecaonine/797The-Count-of-Monte-Cristo.pdf",
              media_type: "book", date: Date.today, title: "The count of montecristo",
              description: "description")
Pigeon.create(summary: "something something", message: message4, length: 125,
              link_to_content: "https://open.spotify.com/episode/6ybdcNPGRMRIYTwXnLVE9w?si=36335912ed7949ac",
              media_type: "podcast", date: Date.today, title: "Bill maher on JRE",
              description: "description")
Pigeon.create(summary: "something something", message: message5, length: 73,
              link_to_content: "https://www.youtube.com/watch?v=TMHqNoIpqbM",
              media_type: "movie", date: Date.today, title: "Weekenders(2021)",
              description: "description")
