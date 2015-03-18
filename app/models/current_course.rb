class CurrentCourse < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  
  validates_presence_of(:user_id, :course_id)
end
