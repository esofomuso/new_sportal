# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#Rails.cache.clear

Dir[Rails.root.join('db', 'seeds', '*seeds.rb').to_s].sort.reverse.each do |file|
puts file.inspect
  load(file)
end
