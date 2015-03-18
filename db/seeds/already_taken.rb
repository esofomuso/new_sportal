require 'config_scripts/config_script'
require 'seeds/loader'
require 'csv'

# rails r db/seeds/already_taken.rb up
class AlreadyTaken < ConfigScript
  def columns
	[:"Export ID", :"Student Full Name", :"Student Preferred Name", :"Student (Next Year) Next Year Grade", :"Student Group", :"Student Enrollment Status", :"Student (Next Year) Enrollment Status", :"Full Name (1) - Online CR Academic History classes- US", :"Course ID (1) - Online CR Academic History classes- US", :"Department ID (1) - Online CR Academic History classes- US", :"Department Name (1) - Online CR Academic History classes- US", :"Is an Elective (1) - Online CR Academic History classes- US", :"Full Name (2) - Online CR Academic History classes- US", :"Course ID (2) - Online CR Academic History classes- US", :"Department ID (2) - Online CR Academic History classes- US", :"Department Name (2) - Online CR Academic History classes- US", :"Is an Elective (2) - Online CR Academic History classes- US", :"Full Name (3) - Online CR Academic History classes- US", :"Course ID (3) - Online CR Academic History classes- US", :"Department ID (3) - Online CR Academic History classes- US", :"Department Name (3) - Online CR Academic History classes- US", :"Is an Elective (3) - Online CR Academic History classes- US", :"Full Name (4) - Online CR Academic History classes- US", :"Course ID (4) - Online CR Academic History classes- US", :"Department ID (4) - Online CR Academic History classes- US", :"Department Name (4) - Online CR Academic History classes- US", :"Is an Elective (4) - Online CR Academic History classes- US", :"Full Name (5) - Online CR Academic History classes- US", :"Course ID (5) - Online CR Academic History classes- US", :"Department ID (5) - Online CR Academic History classes- US", :"Department Name (5) - Online CR Academic History classes- US", :"Is an Elective (5) - Online CR Academic History classes- US", :"Full Name (6) - Online CR Academic History classes- US", :"Course ID (6) - Online CR Academic History classes- US", :"Department ID (6) - Online CR Academic History classes- US", :"Department Name (6) - Online CR Academic History classes- US", :"Is an Elective (6) - Online CR Academic History classes- US", :"Full Name (7) - Online CR Academic History classes- US", :"Course ID (7) - Online CR Academic History classes- US", :"Department ID (7) - Online CR Academic History classes- US", :"Department Name (7) - Online CR Academic History classes- US", :"Is an Elective (7) - Online CR Academic History classes- US", :"Full Name (8) - Online CR Academic History classes- US", :"Course ID (8) - Online CR Academic History classes- US", :"Department ID (8) - Online CR Academic History classes- US", :"Department Name (8) - Online CR Academic History classes- US", :"Is an Elective (8) - Online CR Academic History classes- US", :"Full Name (9) - Online CR Academic History classes- US", :"Course ID (9) - Online CR Academic History classes- US", :"Department ID (9) - Online CR Academic History classes- US", :"Department Name (9) - Online CR Academic History classes- US", :"Is an Elective (9) - Online CR Academic History classes- US", :"Full Name (10) - Online CR Academic History classes- US", :"Course ID (10) - Online CR Academic History classes- US", :"Department ID (10) - Online CR Academic History classes- US", :"Department Name (10) - Online CR Academic History classes- US", :"Is an Elective (10) - Online CR Academic History classes- US", :"Full Name (11) - Online CR Academic History classes- US", :"Course ID (11) - Online CR Academic History classes- US", :"Department ID (11) - Online CR Academic History classes- US", :"Department Name (11) - Online CR Academic History classes- US", :"Is an Elective (11) - Online CR Academic History classes- US", :"Full Name (12) - Online CR Academic History classes- US", :"Course ID (12) - Online CR Academic History classes- US", :"Department ID (12) - Online CR Academic History classes- US", :"Department Name (12) - Online CR Academic History classes- US", :"Is an Elective (12) - Online CR Academic History classes- US", :"Full Name (13) - Online CR Academic History classes- US", :"Course ID (13) - Online CR Academic History classes- US", :"Department ID (13) - Online CR Academic History classes- US", :"Department Name (13) - Online CR Academic History classes- US", :"Is an Elective (13) - Online CR Academic History classes- US", :"Full Name (14) - Online CR Academic History classes- US", :"Course ID (14) - Online CR Academic History classes- US", :"Department ID (14) - Online CR Academic History classes- US", :"Department Name (14) - Online CR Academic History classes- US", :"Is an Elective (14) - Online CR Academic History classes- US", :"Full Name (15) - Online CR Academic History classes- US", :"Course ID (15) - Online CR Academic History classes- US", :"Department ID (15) - Online CR Academic History classes- US", :"Department Name (15) - Online CR Academic History classes- US", :"Is an Elective (15) - Online CR Academic History classes- US", :"Full Name (16) - Online CR Academic History classes- US", :"Course ID (16) - Online CR Academic History classes- US", :"Department ID (16) - Online CR Academic History classes- US", :"Department Name (16) - Online CR Academic History classes- US", :"Is an Elective (16) - Online CR Academic History classes- US", :"Full Name (17) - Online CR Academic History classes- US", :"Course ID (17) - Online CR Academic History classes- US", :"Department ID (17) - Online CR Academic History classes- US", :"Department Name (17) - Online CR Academic History classes- US", :"Is an Elective (17) - Online CR Academic History classes- US", :"Full Name (18) - Online CR Academic History classes- US", :"Course ID (18) - Online CR Academic History classes- US", :"Department ID (18) - Online CR Academic History classes- US", :"Department Name (18) - Online CR Academic History classes- US", :"Is an Elective (18) - Online CR Academic History classes- US", :"Full Name (19) - Online CR Academic History classes- US", :"Course ID (19) - Online CR Academic History classes- US", :"Department ID (19) - Online CR Academic History classes- US", :"Department Name (19) - Online CR Academic History classes- US", :"Is an Elective (19) - Online CR Academic History classes- US", :"Full Name (20) - Online CR Academic History classes- US", :"Course ID (20) - Online CR Academic History classes- US", :"Department ID (20) - Online CR Academic History classes- US", :"Department Name (20) - Online CR Academic History classes- US", :"Is an Elective (20) - Online CR Academic History classes- US", :"Full Name (21) - Online CR Academic History classes- US", :"Course ID (21) - Online CR Academic History classes- US", :"Department ID (21) - Online CR Academic History classes- US", :"Department Name (21) - Online CR Academic History classes- US", :"Is an Elective (21) - Online CR Academic History classes- US", :"Full Name (22) - Online CR Academic History classes- US", :"Course ID (22) - Online CR Academic History classes- US", :"Department ID (22) - Online CR Academic History classes- US", :"Department Name (22) - Online CR Academic History classes- US", :"Is an Elective (22) - Online CR Academic History classes- US", :"Full Name (23) - Online CR Academic History classes- US", :"Course ID (23) - Online CR Academic History classes- US", :"Department ID (23) - Online CR Academic History classes- US", :"Department Name (23) - Online CR Academic History classes- US", :"Is an Elective (23) - Online CR Academic History classes- US", :"Full Name (24) - Online CR Academic History classes- US", :"Course ID (24) - Online CR Academic History classes- US", :"Department ID (24) - Online CR Academic History classes- US", :"Department Name (24) - Online CR Academic History classes- US", :"Is an Elective (24) - Online CR Academic History classes- US", :"Full Name (25) - Online CR Academic History classes- US", :"Course ID (25) - Online CR Academic History classes- US", :"Department ID (25) - Online CR Academic History classes- US", :"Department Name (25) - Online CR Academic History classes- US", :"Is an Elective (25) - Online CR Academic History classes- US", :"Full Name (26) - Online CR Academic History classes- US", :"Course ID (26) - Online CR Academic History classes- US", :"Department ID (26) - Online CR Academic History classes- US", :"Department Name (26) - Online CR Academic History classes- US", :"Is an Elective (26) - Online CR Academic History classes- US", :"Full Name (27) - Online CR Academic History classes- US", :"Course ID (27) - Online CR Academic History classes- US", :"Department ID (27) - Online CR Academic History classes- US", :"Department Name (27) - Online CR Academic History classes- US", :"Is an Elective (27) - Online CR Academic History classes- US", :"Full Name (28) - Online CR Academic History classes- US", :"Course ID (28) - Online CR Academic History classes- US", :"Department ID (28) - Online CR Academic History classes- US", :"Department Name (28) - Online CR Academic History classes- US", :"Is an Elective (28) - Online CR Academic History classes- US", :"Full Name (29) - Online CR Academic History classes- US", :"Course ID (29) - Online CR Academic History classes- US", :"Department ID (29) - Online CR Academic History classes- US", :"Department Name (29) - Online CR Academic History classes- US", :"Is an Elective (29) - Online CR Academic History classes- US", :"Full Name (30) - Online CR Academic History classes- US", :"Course ID (30) - Online CR Academic History classes- US", :"Department ID (30) - Online CR Academic History classes- US", :"Department Name (30) - Online CR Academic History classes- US", :"Is an Elective (30) - Online CR Academic History classes- US", :"Full Name (31) - Online CR Academic History classes- US", :"Course ID (31) - Online CR Academic History classes- US", :"Department ID (31) - Online CR Academic History classes- US", :"Department Name (31) - Online CR Academic History classes- US", :"Is an Elective (31) - Online CR Academic History classes- US", :"Full Name (32) - Online CR Academic History classes- US", :"Course ID (32) - Online CR Academic History classes- US", :"Department ID (32) - Online CR Academic History classes- US", :"Department Name (32) - Online CR Academic History classes- US", :"Is an Elective (32) - Online CR Academic History classes- US", :"Full Name (33) - Online CR Academic History classes- US", :"Course ID (33) - Online CR Academic History classes- US", :"Department ID (33) - Online CR Academic History classes- US", :"Department Name (33) - Online CR Academic History classes- US", :"Is an Elective (33) - Online CR Academic History classes- US", :"Full Name (34) - Online CR Academic History classes- US", :"Course ID (34) - Online CR Academic History classes- US", :"Department ID (34) - Online CR Academic History classes- US", :"Department Name (34) - Online CR Academic History classes- US", :"Is an Elective (34) - Online CR Academic History classes- US", :"Full Name (35) - Online CR Academic History classes- US", :"Course ID (35) - Online CR Academic History classes- US", :"Department ID (35) - Online CR Academic History classes- US", :"Department Name (35) - Online CR Academic History classes- US", :"Is an Elective (35) - Online CR Academic History classes- US", :"Full Name (36) - Online CR Academic History classes- US", :"Course ID (36) - Online CR Academic History classes- US", :"Department ID (36) - Online CR Academic History classes- US", :"Department Name (36) - Online CR Academic History classes- US", :"Is an Elective (36) - Online CR Academic History classes- US", :"Full Name (37) - Online CR Academic History classes- US", :"Course ID (37) - Online CR Academic History classes- US", :"Department ID (37) - Online CR Academic History classes- US", :"Department Name (37) - Online CR Academic History classes- US", :"Is an Elective (37) - Online CR Academic History classes- US", :"Full Name (38) - Online CR Academic History classes- US", :"Course ID (38) - Online CR Academic History classes- US", :"Department ID (38) - Online CR Academic History classes- US", :"Department Name (38) - Online CR Academic History classes- US", :"Is an Elective (38) - Online CR Academic History classes- US", :"Full Name (39) - Online CR Academic History classes- US", :"Course ID (39) - Online CR Academic History classes- US", :"Department ID (39) - Online CR Academic History classes- US", :"Department Name (39) - Online CR Academic History classes- US", :"Is an Elective (39) - Online CR Academic History classes- US", :"Full Name (40) - Online CR Academic History classes- US", :"Course ID (40) - Online CR Academic History classes- US", :"Department ID (40) - Online CR Academic History classes- US", :"Department Name (40) - Online CR Academic History classes- US", :"Is an Elective (40) - Online CR Academic History classes- US", :"Full Name (1) - Online CR current classes", :"Course ID (1) - Online CR current classes", :"Department ID (1) - Online CR current classes", :"Department Name (1) - Online CR current classes", :"Is an Elective (1) - Online CR current classes", :"Full Name (2) - Online CR current classes", :"Course ID (2) - Online CR current classes", :"Department ID (2) - Online CR current classes", :"Department Name (2) - Online CR current classes", :"Is an Elective (2) - Online CR current classes", :"Full Name (3) - Online CR current classes", :"Course ID (3) - Online CR current classes", :"Department ID (3) - Online CR current classes", :"Department Name (3) - Online CR current classes", :"Is an Elective (3) - Online CR current classes", :"Full Name (4) - Online CR current classes", :"Course ID (4) - Online CR current classes", :"Department ID (4) - Online CR current classes", :"Department Name (4) - Online CR current classes", :"Is an Elective (4) - Online CR current classes", :"Full Name (5) - Online CR current classes", :"Course ID (5) - Online CR current classes", :"Department ID (5) - Online CR current classes", :"Department Name (5) - Online CR current classes", :"Is an Elective (5) - Online CR current classes", :"Full Name (6) - Online CR current classes", :"Course ID (6) - Online CR current classes", :"Department ID (6) - Online CR current classes", :"Department Name (6) - Online CR current classes", :"Is an Elective (6) - Online CR current classes", :"Full Name (7) - Online CR current classes", :"Course ID (7) - Online CR current classes", :"Department ID (7) - Online CR current classes", :"Department Name (7) - Online CR current classes", :"Is an Elective (7) - Online CR current classes", :"Full Name (8) - Online CR current classes", :"Course ID (8) - Online CR current classes", :"Department ID (8) - Online CR current classes", :"Department Name (8) - Online CR current classes", :"Is an Elective (8) - Online CR current classes", :"Full Name (9) - Online CR current classes", :"Course ID (9) - Online CR current classes", :"Department ID (9) - Online CR current classes", :"Department Name (9) - Online CR current classes", :"Is an Elective (9) - Online CR current classes", :"Full Name (10) - Online CR current classes", :"Course ID (10) - Online CR current classes", :"Department ID (10) - Online CR current classes", :"Department Name (10) - Online CR current classes", :"Is an Elective (10) - Online CR current classes", :"Full Name (11) - Online CR current classes", :"Course ID (11) - Online CR current classes", :"Department ID (11) - Online CR current classes", :"Department Name (11) - Online CR current classes", :"Is an Elective (11) - Online CR current classes", :"Full Name (12) - Online CR current classes", :"Course ID (12) - Online CR current classes", :"Department ID (12) - Online CR current classes", :"Department Name (12) - Online CR current classes", :"Is an Elective (12) - Online CR current classes", :"Full Name (13) - Online CR current classes", :"Course ID (13) - Online CR current classes", :"Department ID (13) - Online CR current classes", :"Department Name (13) - Online CR current classes", :"Is an Elective (13) - Online CR current classes", :"Full Name (14) - Online CR current classes", :"Course ID (14) - Online CR current classes", :"Department ID (14) - Online CR current classes", :"Department Name (14) - Online CR current classes", :"Is an Elective (14) - Online CR current classes", :"Full Name (15) - Online CR current classes", :"Course ID (15) - Online CR current classes", :"Department ID (15) - Online CR current classes", :"Department Name (15) - Online CR current classes", :"Is an Elective (15) - Online CR current classes", :"Full Name (1) - Online CR - Math, Lang academic history in MS", :"Course ID (1) - Online CR - Math, Lang academic history in MS", :"Department ID (1) - Online CR - Math, Lang academic history in MS", :"Department Name (1) - Online CR - Math, Lang academic history in MS", :"Is an Elective (1) - Online CR - Math, Lang academic history in MS", :"Full Name (2) - Online CR - Math, Lang academic history in MS", :"Course ID (2) - Online CR - Math, Lang academic history in MS", :"Department ID (2) - Online CR - Math, Lang academic history in MS", :"Department Name (2) - Online CR - Math, Lang academic history in MS", :"Is an Elective (2) - Online CR - Math, Lang academic history in MS", :"Full Name (3) - Online CR - Math, Lang academic history in MS", :"Course ID (3) - Online CR - Math, Lang academic history in MS", :"Department ID (3) - Online CR - Math, Lang academic history in MS", :"Department Name (3) - Online CR - Math, Lang academic history in MS", :"Is an Elective (3) - Online CR - Math, Lang academic history in MS", :"Full Name (4) - Online CR - Math, Lang academic history in MS", :"Course ID (4) - Online CR - Math, Lang academic history in MS", :"Department ID (4) - Online CR - Math, Lang academic history in MS", :"Department Name (4) - Online CR - Math, Lang academic history in MS", :"Is an Elective (4) - Online CR - Math, Lang academic history in MS", :"Full Name (5) - Online CR - Math, Lang academic history in MS", :"Course ID (5) - Online CR - Math, Lang academic history in MS", :"Department ID (5) - Online CR - Math, Lang academic history in MS", :"Department Name (5) - Online CR - Math, Lang academic history in MS", :"Is an Elective (5) - Online CR - Math, Lang academic history in MS", :"Full Name (6) - Online CR - Math, Lang academic history in MS", :"Course ID (6) - Online CR - Math, Lang academic history in MS", :"Department ID (6) - Online CR - Math, Lang academic history in MS", :"Department Name (6) - Online CR - Math, Lang academic history in MS", :"Is an Elective (6) - Online CR - Math, Lang academic history in MS", :"Full Name (7) - Online CR - Math, Lang academic history in MS", :"Course ID (7) - Online CR - Math, Lang academic history in MS", :"Department ID (7) - Online CR - Math, Lang academic history in MS", :"Department Name (7) - Online CR - Math, Lang academic history in MS", :"Is an Elective (7) - Online CR - Math, Lang academic history in MS", :"Full Name (8) - Online CR - Math, Lang academic history in MS", :"Course ID (8) - Online CR - Math, Lang academic history in MS", :"Department ID (8) - Online CR - Math, Lang academic history in MS", :"Department Name (8) - Online CR - Math, Lang academic history in MS", :"Is an Elective (8) - Online CR - Math, Lang academic history in MS", :"Full Name (9) - Online CR - Math, Lang academic history in MS", :"Course ID (9) - Online CR - Math, Lang academic history in MS", :"Department ID (9) - Online CR - Math, Lang academic history in MS", :"Department Name (9) - Online CR - Math, Lang academic history in MS", :"Is an Elective (9) - Online CR - Math, Lang academic history in MS", :"Full Name (10) - Online CR - Math, Lang academic history in MS", :"Course ID (10) - Online CR - Math, Lang academic history in MS", :"Department ID (10) - Online CR - Math, Lang academic history in MS", :"Department Name (10) - Online CR - Math, Lang academic history in MS", :"Is an Elective (10) - Online CR - Math, Lang academic history in MS", :"Full Name (11) - Online CR - Math, Lang academic history in MS", :"Course ID (11) - Online CR - Math, Lang academic history in MS", :"Department ID (11) - Online CR - Math, Lang academic history in MS", :"Department Name (11) - Online CR - Math, Lang academic history in MS", :"Is an Elective (11) - Online CR - Math, Lang academic history in MS", :"Full Name (12) - Online CR - Math, Lang academic history in MS", :"Course ID (12) - Online CR - Math, Lang academic history in MS", :"Department ID (12) - Online CR - Math, Lang academic history in MS", :"Department Name (12) - Online CR - Math, Lang academic history in MS", :"Is an Elective (12) - Online CR - Math, Lang academic history in MS", :"Full Name (13) - Online CR - Math, Lang academic history in MS", :"Course ID (13) - Online CR - Math, Lang academic history in MS", :"Department ID (13) - Online CR - Math, Lang academic history in MS", :"Department Name (13) - Online CR - Math, Lang academic history in MS", :"Is an Elective (13) - Online CR - Math, Lang academic history in MS", :"Full Name (14) - Online CR - Math, Lang academic history in MS", :"Course ID (14) - Online CR - Math, Lang academic history in MS", :"Department ID (14) - Online CR - Math, Lang academic history in MS", :"Department Name (14) - Online CR - Math, Lang academic history in MS", :"Is an Elective (14) - Online CR - Math, Lang academic history in MS", :"Full Name (15) - Online CR - Math, Lang academic history in MS", :"Course ID (15) - Online CR - Math, Lang academic history in MS", :"Department ID (15) - Online CR - Math, Lang academic history in MS", :"Department Name (15) - Online CR - Math, Lang academic history in MS", :"Is an Elective (15) - Online CR - Math, Lang academic history in MS", :"Full Name (1) - Online CR - Band and Choir in MS", :"Course ID (1) - Online CR - Band and Choir in MS", :"Department ID (1) - Online CR - Band and Choir in MS", :"Department Name (1) - Online CR - Band and Choir in MS", :"Is an Elective (1) - Online CR - Band and Choir in MS", :"Full Name (2) - Online CR - Band and Choir in MS", :"Course ID (2) - Online CR - Band and Choir in MS", :"Department ID (2) - Online CR - Band and Choir in MS", :"Department Name (2) - Online CR - Band and Choir in MS", :"Is an Elective (2) - Online CR - Band and Choir in MS", :"Full Name (3) - Online CR - Band and Choir in MS", :"Course ID (3) - Online CR - Band and Choir in MS", :"Department ID (3) - Online CR - Band and Choir in MS", :"Department Name (3) - Online CR - Band and Choir in MS", :"Is an Elective (3) - Online CR - Band and Choir in MS", :"Full Name (4) - Online CR - Band and Choir in MS", :"Course ID (4) - Online CR - Band and Choir in MS", :"Department ID (4) - Online CR - Band and Choir in MS", :"Department Name (4) - Online CR - Band and Choir in MS", :"Is an Elective (4) - Online CR - Band and Choir in MS", :"Full Name (5) - Online CR - Band and Choir in MS", :"Course ID (5) - Online CR - Band and Choir in MS", :"Department ID (5) - Online CR - Band and Choir in MS", :"Department Name (5) - Online CR - Band and Choir in MS", :"Is an Elective (5) - Online CR - Band and Choir in MS", :"Full Name (6) - Online CR - Band and Choir in MS", :"Course ID (6) - Online CR - Band and Choir in MS", :"Department ID (6) - Online CR - Band and Choir in MS", :"Department Name (6) - Online CR - Band and Choir in MS", :"Is an Elective (6) - Online CR - Band and Choir in MS", :"Full Name (7) - Online CR - Band and Choir in MS", :"Course ID (7) - Online CR - Band and Choir in MS", :"Department ID (7) - Online CR - Band and Choir in MS", :"Department Name (7) - Online CR - Band and Choir in MS", :"Is an Elective (7) - Online CR - Band and Choir in MS", :"Full Name (8) - Online CR - Band and Choir in MS", :"Course ID (8) - Online CR - Band and Choir in MS", :"Department ID (8) - Online CR - Band and Choir in MS", :"Department Name (8) - Online CR - Band and Choir in MS", :"Is an Elective (8) - Online CR - Band and Choir in MS"]
  end
  
  def cources_already_taken
    # File.read(File.join(Rails.root, 'db', 'seeds/course_registration.csv'))
    File.read(File.join(Rails.root, 'db', 'seeds/courses_already_taken.csv'))
  end
  
  def parsed
    CSV.parse(self.cources_already_taken).map do |line|
      Hash[self.columns.each_with_index.map{|column,index| [column,line[index].to_s.strip]}]
    end
  end
  
	def find_or_create_user(line)
		user = User.find_by_export_id(line[:"Export ID"])
		next_grade = line[:"Student (Next Year) Next Year Grade"]
		#puts "line = #{line} line[:'Export ID'] = #{line[:'Export ID']}  line['Export ID'] = #{line['Export ID']}"
		unless user
			puts ">>>>> We are creating a user because one can not be found: #{line[:'Student Full Name']}"
			user = User.create(
			  :export_id => line[:"Export ID"],
			  :first_name => (line[:"Student Full Name"].split(' ').first rescue line[:"Student Preferred Name"]),
			  :full_name => line[:"Student Full Name"],
			  :preferred_name => line[:"Student Preferred Name"],
			  :last_name => (line[:"Student Full Name"].split(' ').last rescue line[:"Student Preferred Name"]),
			  :current_grade_id => (Grade.find_or_create_by_name(line[:"Student Current Grade"]).id rescue nil),
			  :next_grade_id => Grade.find_or_create_by_name(next_grade).id,
			  :user_type_id => UserType.student.id,
			  :current_enrollment_status => line[:"Student (Next Year) Enrollment Status"],
			  :next_enrollment_status => line[:"Student Enrollment Status"],
			  :email => "#{line[:'Export ID']}@sportal.com",
			  :password => 'Password01'
			   
			)
		end
			
		user
	end
	
	def find_or_create_departments(line)
		depts = {}
		["Online CR Academic History classes- US", "Online CR current classes", "Online CR - Math, Lang academic history in MS", "Online CR - Band and Choir in MS"].each do |s|
			for i in 1..40
		  	d = Department.find_by_code(line[:"Department ID (#{i}) - #{s}"])
		  	
		  	fields = { :name => line[:"Department Name (#{i}) - #{s}"],
		  	:code => line[:"Department ID (#{i}) - #{s}"],
		  	:description => line[:"Department Name (#{i}) - #{s}"] }
		  	
		  	unless d
		  	    d = Department.create(fields) unless line[:"Department ID (#{i}) - #{s}"].blank?
		  	else
		  		d.update_attributes(fields) unless line[:"Department ID (#{i}) - #{s}"].blank?
		  	end
		  	depts["#{i}_#{s}"] = d
			end
		end
		depts
	end
	
	
		
	def find_or_create_courses(line)
		courses = {}
		grade = line[:"Student Current Grade"] || (line[:"Student (Next Year) Next Year Grade"].to_i - 1).to_s
		depts = find_or_create_departments(line)
		puts "depts found in line = #{depts.size}"
		["Online CR Academic History classes- US", "Online CR current classes", "Online CR - Math, Lang academic history in MS", "Online CR - Band and Choir in MS"].each do |s|
			for i in 1..40
			  	dept = depts["#{i}_#{s}"].id rescue nil
			  	elec = line[:"Is an Elective (#{i}) - #{s}"] == 'Y'
			  	c = Course.find_by_code(line[:"Course ID (#{i}) - #{s}"])
			  	
			  	fields = { :name => line[:"Full Name (#{i}) - #{s}"],
			  	:code => line[:"Course ID (#{i}) - #{s}"],
			  	:grade_id => Grade.find_or_create_by_name(grade).id,
			  	:department_id => dept,
			  	:is_elective => elec,
			  	:description => line[:"Full Name (#{i}) - #{s}"]
			  	}
			  	
			  	if c.blank?
			  	  c = Course.create(fields) unless line[:"Course ID (#{i}) - #{s}"].blank? && line[:"Full Name (#{i}) - #{s}"].blank?
			  	else
			  		c.update_attributes(fields) unless line[:"Course ID (#{i}) - #{s}"].blank? && line[:"Full Name (#{i}) - #{s}"].blank?
			  	end
			  	courses["#{i}_#{s}"] = c
			end
		end
		courses
	end
    
  def courses_taken_from_line(line)
    user = find_or_create_user(line)   
    courses = find_or_create_courses(line)
    taken_count = 0
    courses_taken = []
    for c in courses	
   		tc = TakenCourse.find_by_course_id_and_user_id(c[1].id, user.id) rescue nil
	    unless tc.blank?
	    	#puts "#{tc.inspect} Already exists."
	    	taken_count += 0
	    else
	    	tc = TakenCourse.create(:user_id => user.id, :course_id => c[1].id) unless c[1].blank? || user.blank?
	    	
	    	taken_count +=  1 unless tc.blank?
	    	
	    end
	    courses_taken << tc
	end
	[taken_count, courses_taken]
  end

  def bring_up
     puts "Processing course taken courses.....Start #{TakenCourse.all.size} taken courses in total"
     c = 0
     self.parsed.each do |line|
       next if(line[:"Export ID"] == "Export ID" || line["Export ID"] == "Export ID")
       c += self.courses_taken_from_line(line)[0]
     end
     puts "Completed... created #{c} new courses taken !!! Now #{TakenCourse.all.size} courses taken in total"
  end

  def bring_down
    puts "Processing undo for courses taken..... #{TakenCourse.all.size} courses taken in total"
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

AlreadyTaken.new

