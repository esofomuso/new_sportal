class WelcomeController < ApplicationController
  before_action :authenticate_user!
  
  # @!group Exposures
  	  
    # The user that is being created or modified.
    # @return [User]
    expose(:user){current_user}
    
    # The user that is being created or modified.
    # @return [User]
    expose(:user_type){user.user_type}
    
    # The current grade of current user.
    # @return [Grade]
    expose(:current_grade){ user.current_grade }
    
    # The next grade of current user.
    # @return [Grade]
    expose(:next_grade){ user.next_grade }
    
    # All departments.
    # @return [Department]
    expose(:departments){ Department.all.order(:name).uniq }
    
    # Active courses.
    # @return [Course]
    expose(:courses) { Course.where(active: true) }
    
    # Active electives.
    # @return [Elective]
    expose(:active_electives) { next_grade.electives.where(active: true) }
    
    # The course that is being worked on.
    # @return [Course]
    expose(:course)
    
    # The taken_courses for current user.
    # @return [Relation<Course>]
    expose(:taken_courses) { user.t_courses.group_by{|c| c.department.name rescue 'Others'}.sort } #params[:dept_id] ? user.t_courses.where(:department_id => params[:dept_id]) : user.t_courses.where(:department_id => departments.first.id) }
    
    # The recommended_courses of current user along with their sub_classes.
    # @return [Course]
    expose(:recommended_courses_arr) { user.r_courses.map{|rc| [rc, rc.sub_courses]}.flatten }
    
    # The recommended_courses for current user.
    # @return [Relation<Course>]
    expose(:recommended_courses) { (recommended_courses_arr - current_courses_arr).group_by{|c| c.department.name rescue 'Others'} }
    
    # The appeal_courses of current user.
    # @return [Relation<Course>]
    expose(:appeal_courses) { (user.a_courses - current_courses_arr).group_by{|c| c.department.name rescue 'Others'} }
    
    # The appealed_courses selected by current user.
    # @return [Relation<Course>]
    expose(:appeal_courses_arr) { user.a_courses.where(active: true) }
    
    # The electives selected by current user.
    # @return [Relation<Course>]
    expose(:selected_electives) { user.electives.where(active: true) }
    
    # The electives available to be selected by current user.
    # @return [Relation<Course>]
    expose(:available_electives) { active_electives - selected_electives }
    
    # The current_courses selected by current user.
    # @return [Relation<Course>]
    expose(:current_courses_arr) { user.c_courses.where(active: true) }
    
    # The current_courses selected by current user.
    # @return [Relation<Course>]
    expose(:current_courses) { current_courses_arr.group_by{|c| c.department.name rescue 'Others'} }
    
    expose(:student_appeals) { user.student_department_appeals }
    
    # The current_courses that is being created.
    # @return [Relation<Course>]
    expose(:grade_courses) { (next_grade.courses.where(active: true).order(:name).uniq - current_courses_arr - recommended_courses_arr - appeal_courses_arr).group_by{|c| c.department.name rescue 'Others'} }
        
    # @!attribute user_from_email
    # The user who has the email.
    # @return [User]
    expose(:user_from_email) { User.find_by_email(params[:email]) }
    
  def index
    puts ">>>>>>>>>>> The incoming parameter : #{params.inspect}"
    
    if user.active
     	user.is_admin? ? (redirect_to :admin) : ''
     	user.is_teacher? ? (render :welcome_path) : ''
    else
     	current_user = nil
     	flash[:error] = 'Inactive Account'
     	redirect_to destroy_user_session_path
    end
     
    if !params[:id].blank? && user.active
      incoming_department_id = params[:id] unless params[:id].blank? 
      @department = Department.find_by_id(incoming_department_id)
      @offered_courses = Course.find_courses_by_grade(user.next_grade)
      # @current_courses = CurrentCourse.find_by_id(user.id, :order => "order DESC")
      # @current_courses = CurrentCourse.find(:all, :conditions => ["user_id = ?", user.id], :order => "order DESC")
      @current_courses = CurrentCourse.where(:user_id => user.id).order("select_order ASC")
      #@current_courses = CurrentCourse.find_by_user_id(user.id).order(:order)

      student_appeal = StudentDepartmentAppeal.find_by_user_id_and_department_id(user.id, @department.id)
      @comment = student_appeal.comment if !student_appeal.nil?
    end
  end
  
  def teachers_welcome
    
  end
  
  def summary
  	respond_to do |format|
      format.html do 
        render :html => "summary"
      end
      format.pdf do
      # 	render :pdf => 'summary.pdf', :formats => [:html]
         render :pdf => "summary", :formats => [:html]
      end
  	end
  end
  
  def electives
  end

  def stud_data
  	render json: User.all.to_json
  end

  def dept_data
    taken_courses
    render json: departments.select([:id,:name,:description]).to_json
  end
  
  def rec_course_data
  	render json: recommended_courses.to_json #.map{|rc| {'id' => rc.id, 'title' => rc.name, 'drag' => true}}.flatten.to_json
  end
  
  def curr_course_data
  	render json: current_courses.to_json #.map{|cc| {'id' => cc.id, 'title' => cc.name, 'drag' => true}}.flatten.to_json
  end
  
  def dept_grade_courses_data
    puts ">>>>>>>>>>> This is the dept_grade_courses_data and params = #{params.inspect}"
    puts params.inspect
    dept = Department.find_by_name(params[:dept])
    (grade_courses & dept.courses).map{|cc| {'id' => cc.id, 'title' => cc.name}}.to_json
  end
  
#  def get_courses
#  	dept_id = params[:dept_id].to_i || departments.first.id
#  	puts ">>>>>>>> inside get_courses and params = #{params.inspect} and dept_id = #{dept_id}"
#  	taken_courses = user.t_courses.where(:department_id => dept_id)
#  	puts "taken_courses = #{taken_courses.inspect}"
#  	respond_to do |format|
#  	  format.js
#  	end
#  	
#  end
  def store_course
  	puts params.inspect
    student_courses = courses.where(id: params[:id].split(','))
    student_courses.each do |course|
    	user.c_courses << course unless user.c_courses.include?(course)
    	# TODO Does selecting a course select the sub courses too?
#    	course.sub_courses.each do |c|
#    		user.c_courses << c unless user.c_courses.include?(c)
#    	end
    end
    puts current_courses.inspect
    puts user.c_courses.inspect
  	render json: current_courses{|sc| {'id' => sc.id, 'title' => sc.name, 'drag' => true}}.flatten.to_json
  end
  
  def store_appeal
  	puts params.inspect
    student_appeals = courses.where(id: params[:id].split(','))
    student_appeals.each do |course|
    	user.a_courses << course unless user.a_courses.include?(course)
    end
    puts appeal_courses.inspect
    puts user.a_courses.inspect
  	render json: appeal_courses{|sc| {'id' => sc.id, 'title' => sc.name, 'drag' => true}}.flatten.to_json
  end
  
  def store_elective
  	puts params.inspect
    s_electives = Elective.where(id: params[:id].split(','))
    s_electives.each do |e|
    	user.electives << e unless user.electives.include?(e)
    end
    puts s_electives.inspect
    puts user.electives.inspect
  	render json: selected_electives{|se| {'id' => se.id, 'title' => se.name, 'drag' => true}}.flatten.to_json
  end
  
  def remove_selection
    course = courses.find_by_id(params[:id])
    user.c_courses.delete(course) if user.c_courses.include?(course)
  	render json: recommended_courses{|sc| {'id' => sc.id, 'title' => sc.name, 'drag' => true}}.flatten.to_json
  end
  
  def remove_appeal_option
  	course = courses.find_by_id(params[:id])
    user.a_courses.delete(course) if user.a_courses.include?(course)
  	render json: grade_courses{|sc| {'id' => sc.id, 'title' => sc.name, 'drag' => true}}.flatten.to_json
  end
  	
  
  def remove_elective
  	course = Elective.find_by_id(params[:id])
    user.electives.delete(course) if user.electives.include?(course)
  	render json: user.electives{|sc| {'id' => sc.id, 'title' => sc.name, 'drag' => true}}.flatten.to_json
  end
  	
  
  def note_to_scheduler
  	Rails.logger.info ">>>>>> params = #{params}"
  	user.update_attribute(:student_notes, params[:student][:notes]) rescue nil
  end
  
  def edit
  end
  
  def change_password
  end
  
  # This action receives a form submission to update current_user.
  #
  # @request_param [Hash] password_info
  #   The current password, new password and new confirmation.
  #
  # OR
  #
  # @request_param [Hash] user
  #   The immediate attributes of the current_user.
  #
  # @renders index using ajax
  #   If there are errors, we see the original form.
  #   Otherwise the user details.
  def update    
    user = self.current_user

    password_info = params[:password_info] || {}
    if password_info.blank?
    	user.attributes = params[:user].permit(:export_id, :first_name, :last_name, :preferred_name, :full_name, :email)
    else
	    if password_info[:current].blank? || password_info[:new].blank? || password_info[:new_confirmation].blank?
	    	user.errors.add(:new_password, "can't be blank") if password_info[:new].blank?
	    	user.errors.add(:'New password (confirmation)', "can't be blank") if password_info[:new_confirmation].blank?
      end
      user.errors.add(:current_password, 'is invalid') unless user.valid_password?(password_info[:current])
      user.errors.add(:new_password, 'did not match the confirmation') unless password_info[:new] == password_info[:new_confirmation]
      user.password = password_info[:new]
      user.password_confirmation = password_info[:new_confirmation]
	  end
    if user.errors.blank? && user.save
    	sign_in(user, :bypass => true)
      flash[:success] = "Successfully Updated Your Account Information."
    end
    redirect_to '/'
  end
    
    
end
