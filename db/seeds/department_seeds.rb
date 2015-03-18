puts "Loading db/seeds/department_seeds.rb"

[["Mathematics", "MATH"],["English", "ENG"],["History", "HIST"],["Science", "SCI"],["Classical Languages", "CLAS"],["Languages", "LANG"]].each do |d,c|
  unless Department.find_by_code(c)
  	Department.create(:name => d, :description => d, :code => c)
  end
end