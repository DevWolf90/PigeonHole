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

Message.create()
