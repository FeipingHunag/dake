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
