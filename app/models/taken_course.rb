class TakenCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates_presence_of(:user_id, :course_id)
end
