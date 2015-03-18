class Admin::BaseAdminController < ApplicationController

  layout "admin"
  
  helper AdminHelper
  before_action :authenticate_user!
  before_action :is_admin? , except: [:move_course_request_down, :move_course_request_up, :student_add_current_course, :student_remove_current_course, :student_add_appeal, :student_add_other_course, :student_remove_other_course, :student_remove_appeal
  ]
  
  # @!group Exposures
  	  
    # The current user.
    # @return [User]
    expose(:user){current_user}
    
    # The user_type of current_user
    # @return [User]
    expose(:user_type){user.user_type}
    
    # All departments.
    # @return [Department]
    expose(:departments){ Department.all.order(:name).uniq }
    
    # All courses
    # @return [Course]
    expose(:courses){ Course.order(:id).uniq }
    
    # All electives
    # @return [Electives]
    expose(:electives){ Elective.all.order(:name, :grade_id).uniq }
    
    # All grades
    # @return [Grade]
    expose(:grades)
    
    # All users
    # @return [User]
    expose(:users)
    
    # All students
    # @return [User]
    expose(:students){ User.students }
    
    # All students
    # @return [User]
    expose(:teachers){ User.teachers }
    
    # All students
    # @return [User]
    expose(:admins){ User.admins }
    
#    def 
#    
#    private
    
    def is_admin?
    	!user.is_admin? ? (redirect_to :root) : '' 
    end
  
end
