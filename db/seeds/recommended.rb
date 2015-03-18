#!/usr/bin/env ruby
require 'config_scripts/config_script'
require 'seeds/loader'
require 'csv'

# rails r db/seeds/recommended.rb up
class Recommended < ConfigScript
  
  def columns
    [:"Export ID", :"Student (Next Year) Next Year Grade", :"Student Preferred Name", :"Student Last Name", :"Recommended Department ID (1) - Course Recommendations Cluster", :"Recommended Course ID (1) - Course Recommendations Cluster", :"Recommended Course Name (1) - Course Recommendations Cluster", :"Recommended Department ID (2) - Course Recommendations Cluster", :"Recommended Course ID (2) - Course Recommendations Cluster", :"Recommended Course Name (2) - Course Recommendations Cluster", :"Recommended Department ID (3) - Course Recommendations Cluster", :"Recommended Course ID (3) - Course Recommendations Cluster", :"Recommended Course Name (3) - Course Recommendations Cluster", :"Recommended Department ID (4) - Course Recommendations Cluster", :"Recommended Course ID (4) - Course Recommendations Cluster", :"Recommended Course Name (4) - Course Recommendations Cluster", :"Recommended Department ID (5) - Course Recommendations Cluster", :"Recommended Course ID (5) - Course Recommendations Cluster", :"Recommended Course Name (5) - Course Recommendations Cluster", :"Recommended Department ID (6) - Course Recommendations Cluster", :"Recommended Course ID (6) - Course Recommendations Cluster", :"Recommended Course Name (6) - Course Recommendations Cluster", :"Recommended Department ID (7) - Course Recommendations Cluster", :"Recommended Course ID (7) - Course Recommendations Cluster", :"Recommended Course Name (7) - Course Recommendations Cluster", :"Recommended Department ID (8) - Course Recommendations Cluster", :"Recommended Course ID (8) - Course Recommendations Cluster", :"Recommended Course Name (8) - Course Recommendations Cluster", :"Recommended Department ID (9) - Course Recommendations Cluster", :"Recommended Course ID (9) - Course Recommendations Cluster", :"Recommended Course Name (9) - Course Recommendations Cluster", :"Recommended Department ID (10) - Course Recommendations Cluster", :"Recommended Course ID (10) - Course Recommendations Cluster", :"Recommended Course Name (10) - Course Recommendations Cluster"]
  end
  
  def cources_recommended
    File.read(File.join(Rails.root, 'db', 'seeds/recommended_courses.csv'))
  end
  
  def parsed
    CSV.parse(self.cources_recommended).map do |line|
      Hash[self.columns.each_with_index.map{|column,index| [column,line[index].to_s.strip]}]
    end
  end
  
  def find_or_create_user(line)
  	user = User.find_by_export_id(line[:"Export ID"])
  	unless user
  	  puts ">>>>> We are creating a user because one can not be found: #{line[:'Student Preferred Name']} #{line[:'Student Last Name']}"
  	    user = User.create(
  	      :export_id => line[:"Export ID"],
  	      :first_name => line[:"Student Preferred Name"],
  	      :last_name => line[:"Student Last Name"],
  	      :preferred_name => line[:"Student Preferred Name"],
  	      :next_grade_id => Grade.find_or_create_by_name(line[:"Student (Next Year) Next Year Grade"]).id,
  	      :user_type_id => UserType.student.id,
  	      :email => "#{line[:'Export ID']}@sportal.com",
  	      :password => 'Password01'
  	    )
  	end
  	
  	user
  end
  
  def find_or_create_departments(line)
  	depts = {}
  	for i in 1..10
	  	d = Department.find_by_code(line[:"Recommended Department ID (#{i}) - Course Recommendations Cluster"])
	  	unless d
	  	    d = Department.create(
	  	      :name => line[:"Recommended Department ID (#{i}) - Course Recommendations Cluster"],
	  	      :code => line[:"Recommended Department ID (#{i}) - Course Recommendations Cluster"],
	  	      :description => line[:"Recommended Department ID (#{i}) - Course Recommendations Cluster"]
	  	      ) unless line[:"Recommended Department ID (#{i}) - Course Recommendations Cluster"].blank?
	  	end
	  	depts[i] = d
  	end
  	depts
  end
  
  def find_or_create_courses(line)
  	departments = find_or_create_departments(line)
  	#puts departments.inspect
  	courses = {}
  	for i in 1..10
	  	c = Course.find_by_code(line[:"Recommended Course ID (#{i}) - Course Recommendations Cluster"])
	  	unless c
	  	    c = Course.create(
	  	      :name => line[:"Recommended Course Name (#{i}) - Course Recommendations Cluster"],
	  	      :code => line[:"Recommended Course ID (#{i}) - Course Recommendations Cluster"],
	  	      :description => line[:"Recommended Course Name (#{i}) - Course Recommendations Cluster"],
	  	      :grade_id => Grade.find_or_create_by_name(line[:"Student (Next Year) Next Year Grade"]).id,
	  	      :department_id => (departments[i].id unless departments[i].blank?)
	        ) unless line[:"Recommended Course Name (#{i}) - Course Recommendations Cluster"].blank? && line[:"Recommended Course ID (#{i}) - Course Recommendations Cluster"].blank?
	  	else
	  		c.update_attributes(:department_id => departments[i].id) unless departments[i].blank?
	  	end
	  	courses[i] = c
  	end
  	courses
  end
  
  def recommendation_taken_from_line(line)
  	user = find_or_create_user(line) 
  	#puts user.inspect  
    courses = find_or_create_courses(line)
    created_rec = 0
    recs = []
    for c in courses
    	#puts c.inspect
    	rc = RecommendedCourse.find_by_course_id_and_user_id(c[1].id, user.id) rescue nil
	    unless rc.blank?
	    	#puts "#{rc.inspect} Already exists."
	    	created_rec += 0
	    else
	    	rc = RecommendedCourse.create(:user_id => user.id, :course_id => c[1].id) unless c[1].blank? || user.blank?
	    	created_rec +=  1 unless rc.blank?
	    	
	    end
	    recs << rc
    end
    [created_rec, recs]
  end

   def bring_up
     puts "Processing course recommendations.....Start #{RecommendedCourse.all.size} course recommendations in total"
     c = 0
     self.parsed.each do |line|
       next if(line[:"Export ID"] == "Export ID" || line["Export ID"] == "Export ID")
       #user = find_or_create_user(line)
       #puts user.inspect
       #c += 1 if user
       c += self.recommendation_taken_from_line(line)[0]
     end
     puts "Completed... created #{c} new course recommendations !!! Now #{RecommendedCourse.all.size} course recommendations in total"
     #puts "#{c} Users"
   end

  def bring_down
    puts "Processing undo for course recommendations..... #{RecommendedCourse.all.size} course recommendations in total"
    c = 0
    self.parsed.each do |line|
      next if(line[:"Export ID"] == "Export ID" || line["Export ID"] == "Export ID")
      course_recommendations = recommendation_taken_from_line(line)[1] #cources_recommended.where(user_id => find_or_create_user(line).id)
      begin
	      c = course_recommendations.size 
	      course_recommendations.destroy_all unless c == 0
      rescue 
      	puts "Unable to destroy:- #{c} course_recommendations"
      end
    end
    puts "Successfully destroyed #{c} course_recommendations!!!"
  end
end

Recommended.new

