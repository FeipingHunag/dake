# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create [{nickname: 'fph',email:'huang900107@163.com', password: '900107'},
             {nickname: 'vvdpzz',email:'vvdpzz@gmail.com', password: 'vvdpzz'},
             {nickname: 'kit', email:'kityang@gmail.com', password: 'kityang'}
            ]
user = User.first
group = user.groups.create! name: 'dake boys', description: 'so many boys...'

u1 = User.first
u2 = User.last

content = "http://dake-photos.b0.upaiyun.com/uploads/4a4bd685-b371-43fb-9097-b792dc1bb25c.png"

u1.send_message_to u2, content: content, mtype: 1
