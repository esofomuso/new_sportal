class ElectedCourse < ActiveRecord::Base
  belongs_to :elective
  belongs_to :user
  
  validates_presence_of(:user_id, :elective_id)
end
