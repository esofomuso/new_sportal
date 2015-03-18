class Department < ActiveRecord::Base
  has_many :courses
  has_many :electives
  
  has_many :current_users
  has_many :current_students, :through => :current_users, :source => :user
  
  validates :name, presence: true
  validates_uniqueness_of :name
end
