class Elective < ActiveRecord::Base
  belongs_to :department
  belongs_to :grade
  
  has_many :current_students, :through => :current_electives, :source => :user
  has_many :current_teachers, :through => :current_electives, :source => :user
  
  # The elective' users
  has_many :elected_courses
  has_many :e_students, -> { where active: true }, through: :elected_courses, :source => :user
  	
   
  validates :name, presence: true
  validates_uniqueness_of :name
end
