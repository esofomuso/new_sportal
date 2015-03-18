puts "Loading db/seeds/grade_seeds.rb"

[5,6,7,8,9,10,11,12].each do |g|
  Grade.find_or_create_by_name_and_description(g.to_s, "#{g}th Grade")
end