class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # The courses already takentaken
  has_many :taken_courses
  has_many :t_courses, through: :taken_courses, :source => :course
  
  # The courses  recommended
  has_many :recommended_courses
  has_many :r_courses, -> { where active: true }, through: :recommended_courses, :source => :course

  # The currently chosen courses
  has_many :current_courses
  has_many :c_courses, -> { (where active: true).order('select_order') }, through: :current_courses, :source => :course
	
  # The courses appealed for
  has_many :appeal_courses
  has_many :a_courses, -> { where active: true }, through: :appeal_courses, :source => :course
  	
  # The users's electives
  has_many :elected_courses
  has_many :electives, -> { where active: true }, through: :elected_courses, :source => :elective
  
  # The users's appeals
  has_many :student_department_appeals
  has_many :appeals, through: :student_department_appeals
  	
  # This is the school grade the user will be in
  belongs_to :current_grade, :class_name => "Grade"
  belongs_to :next_grade, :class_name => "Grade"
  belongs_to :user_type
  
  # Validations ----------------------------------------------------------------
  validates_uniqueness_of :email
  
  def self.sorted_taken_courses(user_id, department)
    user = User.find_by_id(user_id)
    
    sorted_courses = {}
    
    user.taken_courses.each do |course|
      unless course.course.department.blank?
        puts "checking course department id : #{department.id}"
        puts "checking course department to check to : #{course.course.department.id}"
        
        if department.id == course.course.department.id
          sorted_courses[course.course.code.to_i] = course.course
        end
      end
    end
    puts ">>>> About to try and display the sorted_courses!!!!"
    puts ">>>> Coursed from the model : #{sorted_courses.inspect}"
    
    sorted_courses.sort
    
  end
  
  def self.sorted_recommended_courses(user_id, department)
    user = User.find_by_id(user_id)
    
    sorted_courses = {}
    
    user.recommended_courses.each do |recommended_course|
      unless recommended_course.course.department.blank?
        if department.id == recommended_course.course.department.id
          unless recommended_course.selected
            if recommended_course.course.active
              sorted_courses[recommended_course.course.code] = recommended_course
            end
          end
        end
      end
    end
    
    sorted_courses.sort
  end
  
  def self.sorted_offered_courses(user_id, department_id)
    user = User.find_by_id(user_id)
    offered_courses = Course.find_courses_by_grade(user.next_grade)
    
    sorted_courses = {}
    
    offered_courses.each do |course|
      if course.active
        unless course.department.blank?
          if department_id.id == course.department.id
            if !user.users_current_courses.include?(course)
              unless user.users_appeal_courses.include?(course) || user.users_recommended_course.include?(course)
                if user.users_recommended_course.include?(course.main_course) || course.main_course.nil?
                  sorted_courses[course.code] = course
                end
              end
            end
          end
        end
      end
    end
    
    sorted_courses.sort
  end
  
  def users_appeal_courses
    appeals = []
    
    appeal_courses.each do |appeal_course|
      appeals << Course.find_by_id(appeal_course.course_id)
    end
    
    appeals
  end
  
  def users_recommended_course
    recommended = []
    
    recommended_courses.each do |course|
      recommended << Course.find_by_id(course.course_id)
    end
    
    recommended
  end
  
  def users_current_courses
    user_current_courses = []
    
    current_courses.each do |course|
      user_current_courses << Course.find_by_id(course.course_id)
      #logger.info ">>>>>>>>>>>>> Adding this course to the current course array : #{user_current_courses.inspect}"
    end


    
    user_current_courses 
  end
  
  def name
  	self.full_name.blank? ? "#{self.first_name} #{self.last_name}" : self.full_name
  end

  def possessive_name
  	self.preferred_name.blank? ? "#{self.name}'s" : "#{self.preferred_name}'s"
  end
  
  def is_admin?
  	self.user_type == UserType.admin rescue false
  end
  
  def is_student?
  	self.user_type == UserType.student rescue false
  end
  
  def is_teacher?
  	self.user_type == UserType.teacher rescue false
  end
  
  def self.students
  	where :user_type_id => UserType.student.id
  end
  
  def self.teachers
  	where :user_type_id => UserType.teacher.id
  end

  def self.admins
    where :user_type_id => UserType.admin.id
  end
end
