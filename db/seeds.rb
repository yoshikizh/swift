# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

node = Node.create name: "node1" ,intro: "讨论"
node = Node.create name: "node2" ,intro: "项目"
node = Node.create name: "node3" ,intro: "招聘"
node = Node.create name: "node4" ,intro: "灌水"
node = Node.create name: "node5" ,intro: "反馈"