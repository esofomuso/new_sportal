class Course < ActiveRecord::Base
  belongs_to :main_course, class_name: "Course"
  belongs_to :department
  belongs_to :grade
  has_many :current_courses
  has_many :current_electives, -> { where is_elective: true }, through: :current_courses, :source => :course
  has_many :current_students, :through => :current_courses, :source => :user
  has_many :current_teachers, :through => :current_courses, :source => :user

  has_many :sub_courses, class_name: "Course", foreign_key: "main_course_id"


  scope :find_courses_by_grade, ->(grade_id) { where(:grade_id => grade_id).order(:name)}
  scope :find_courses_by_grade_and_department, ->(grade_id, department_id) { where(:grade_id => grade_id, :department_id => department_id)}
  scope :find_courses_by_grade_and_active, ->(grade_id, active) {where(:grade_id => grade_id, :active => active)}

  def course_sub_courses
    my_courses = []
    
    sub_courses.each do |sub_course|
      my_courses << Course.find_by_id(sub_course.id)
    end
    
    my_courses
  end
  
  # validates :name, presence: true
  # validates_uniqueness_of :name
end
