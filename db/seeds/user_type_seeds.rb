puts "Loading db/seeds/user_type_seeds.rb"

['Admin', 'Student', 'Teacher'].each do |t|
  UserType.find_or_create_by_name(t)
end

User.create(:email => 'admin@sportal.com', :password => 'Password01', :user_type_id => UserType.admin.id, :first_name => 'Admin', :last_name => 'User') rescue nil