require 'config_scripts/config_script'
require 'seeds/loader'
require 'csv'

# rails r db/seeds/course_registration.rb up
class CourseRegistration < ConfigScript
  def columns
	  [:"Export ID", :"Student First Name", :"Student Preferred Name", :"Student Last Name", :"Student Current Grade", :"Student (Next Year) Enrollment Status", :"Student (Next Year) Next Year Grade", :"Student E-Mail"]
  end
  
  def cources_already_taken
    File.read(File.join(Rails.root, 'db', 'seeds/course_registration.csv'))
  end
  
  def parsed
    CSV.parse(self.cources_already_taken).map do |line|
      Hash[self.columns.each_with_index.map{|column,index| [column,line[index].to_s.strip]}]
    end
  end
  
  def find_or_create_user(line)
  	next_grade = line[:"Student (Next Year) Next Year Grade"]
		user = User.create(
		  :export_id => line[:"Export ID"],
		  :first_name => (line[:"Student First Name"] rescue line[:"Student Preferred Name"]),
		  :full_name => line[:"Student Full Name"],
		  :preferred_name => line[:"Student Preferred Name"],
		  :last_name => (line[:"Student Last Name"] rescue line[:"Student Preferred Name"]),
		  :current_grade_id => (Grade.find_or_create_by_name(line[:"Student Current Grade"]).id rescue nil),
		  :next_grade_id => Grade.find_or_create_by_name(next_grade).id,
		  :user_type_id => UserType.student.id,
		  :current_enrollment_status => line[:"Student (Next Year) Enrollment Status"],
		  # :next_enrollment_status => line[:"Student Enrollment Status"],
		  :email => line[:"Student E-Mail"],
		  :password => 'Password01'
		)
		
		if user.current_enrollment_status == "Pending"
		  puts "Setting user to inactive!"
		  user.update_attribute('active', false)

		end
		# puts "Did we create a user : #{user.inspect}"
  	user
  end

  def bring_up
    file_parsed = self.parsed
    
    puts "Processing users ...... Start #{file_parsed.size} users in total"
    c = 0
    self.parsed.each do |line|
      next if(line[:"Export ID"] == "Export ID" || line["Export ID"] == "Export ID")
      if self.find_or_create_user(line)
        c += 1
      end
      # c += self.find_or_create_user(line)[0]
    end
    puts "Completed... created #{c} users"
  end

  def bring_down

    c = 0
    self.parsed.each do |line|
      next if(line[:label] == 'label' || line['label'] == 'label')
      courses_taken = courses_taken_from_line(line)[1] 
      begin
        c = courses_taken.size 
        courses_taken.destroy_all unless c == 0
      rescue 
      	puts "Unable to destroy:- #{c} courses taken"
      end
    end
    puts "Successfully destroyed #{c} courses taken!!!"
  end
end

CourseRegistration.new