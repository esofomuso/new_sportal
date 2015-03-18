class Grade < ActiveRecord::Base
  has_many :users
  has_many :courses
  has_many :electives, -> { where is_elective: true }, class_name: "Course", foreign_key: "grade_id"
  
  validates :name, presence: true
  validates_uniqueness_of :name
end
