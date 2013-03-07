# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.delete_all
#List of seed products for dev db
Product.create(title: 'Programming Ruby 1.9',
	description:
		%{<p>
			Ruby is the fastest growing and most exciting dynamic language out there. If you need to get working programs delivered fast, you should add Ruby to your toolbox.
			</p>},
	image_url: 'ruby.png',
	price: 49.95)
Product.create(title: 'Essential Java Tools',
	description:
		%{<p>
			Java is a language whose cross platform capabilities have it popping up everywhere. Taking a closer look at the tools that can help in building and deploying Java applications is huge bonus to productivity; such gains won't be found elsewhere.
			</p>},
	image_url: 'java.jpg',
	price: 39.95)