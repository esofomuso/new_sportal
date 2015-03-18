class Admin::StudentsController < Admin::BaseAdminController
  before_action :set_student, only: [:update]
    
  # !group Exposures
  	  
    # The current student.
    # return [User]
    expose(:student){ students.find_by_id(params[:id]) }
    
  # GET /students
  # GET /students.json
  def index
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
  end

  # GET /students/1/edit
  def edit
    student = User.find_by_id(params[:id])
    
    @courses = Course.order('name ASC')
    logger.info "What student are we looking for : #{student.inspect}"
    # @offered_courses =  Course.find_courses_by_grade(student.next_grade)
    @offered_courses = Course.where(grade: student.next_grade, active: true)
  end

  # POST /students
  # POST /students.json
  def create
    @student = User.students.new(student_params)
    @student.password = 'Password01'
    respond_to do |format|
      if @student.save
        format.html { redirect_to edit_admin_student_path, notice: 'student was successfully created.' }
        format.json { render action: 'show', status: :created, location: @student }
      else
        format.html { render action: 'new' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to edit_admin_student_path(@student), notice: 'student was successfully updated.' }
        format.json { render action: 'show', status: :updated, location: @student }
        #format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def move_course_request_up
    current_course = CurrentCourse.find_by_id(params[:current_course])

    unless current_course.select_order.nil?
      course_to_move = CurrentCourse.find_by_select_order_and_user_id(current_course.select_order - 1, current_course.user_id)

      if !course_to_move.nil?
        course_to_move.update_attribute(:select_order, current_course.select_order)
        current_course.update_attribute(:select_order, current_course.select_order - 1)
      end
    end

    respond_to do |format|
      format.html { redirect_to root_path(id: params[:return_id]), notice: "Course moved."}
    end
  end

  def move_course_request_down
    current_course = CurrentCourse.find_by_id(params[:current_course])

    unless current_course.select_order.nil?
      course_to_move = CurrentCourse.find_by_select_order_and_user_id(current_course.select_order + 1, current_course.user_id)

      if !course_to_move.nil?
        course_to_move.update_attribute(:select_order, current_course.select_order)
        current_course.update_attribute(:select_order, current_course.select_order + 1)
      end
    end

    respond_to do |format|
      format.html { redirect_to root_path(id: params[:return_id]), notice: "Course moved."}
    end
  end


  # TODO: The next two methods are doing the exact same thing. Refactor into one method
  def add_previous_course
    student = User.find_by_id(params[:student_id])
    course = Course.find_by_id(params[:course_to_add])

    respond_to do |format|
      student.taken_courses << TakenCourse.create(:user => student, :course => course)
      student.save!
      format.html { redirect_to edit_admin_student_path(student), notice: 'Added previously taken course.' }
    end
  end

  def add_recommended_course
    student = User.find_by_id(params[:student_id])
    course = Course.find_by_id(params[:course_to_add])

    respond_to do |format|
      student.recommended_courses << RecommendedCourse.create(:user => student, :course => course, :selected => false)
      student.save!
      format.html { redirect_to edit_admin_student_path(student), notice: 'Added recommended course.' }
    end
  end

  def add_current_course
    student = User.find_by_id(params[:student_id])
    course = Course.find_by_id(params[:course_to_add])
    


    respond_to do |format|
      student.current_courses << CurrentCourse.create(:user => student, :course => course)
      student.save!
      
      # select_current_course(student, course)
      
      format.html { redirect_to edit_admin_student_path(student), notice: 'Added current course.' }
    end
  end
  
  def student_add_current_course
    student = User.find_by_id(params[:student_id])
    course = Course.find_by_id(params[:course_to_add])

    respond_to do |format|
      students_current_courses = CurrentCourse.where(user: student)
      student.current_courses << CurrentCourse.create(:user => student, :course => course, :select_order => students_current_courses.count+1, :selected => true)

      recommended_course = RecommendedCourse.find_by_user_id_and_course_id(student.id, course.id)
      unless recommended_course.nil?
        recommended_course.update_attribute("selected", true)
      end

      student.save!
      
      format.html { redirect_to root_path(id: params[:return_id]), notice: "Course Added."}
    end
  end
  
  def student_add_other_course
    student = User.find_by_id(params[:user_id])
    course = Course.find_by_id(params[:course_id])
    
    respond_to do |format|
      AppealCourse.create(:user => student, :course => course)
      format.html { redirect_to root_path(id: params[:return_id]), notice: "Appeal saved." }
    end    
  end
  
  def student_remove_other_course
    student = User.find_by_id(params[:user_id])
    course = Course.find_by_id(params[:course_id])
    
    respond_to do |format|
      logger.info "What are we searching for user_id : #{student.id} and course_id : #{course.id}"
      other_course = AppealCourse.find_by_user_id_and_course_id(student, course)
      logger.info "Removing the following course : #{other_course.inspect}"
      other_course.destroy!
      format.html { redirect_to root_path(id: params[:return_id]), notice: "Appeal Removed."}
    end
  end
  
  def student_add_appeal
    student = User.find_by_id(params[:user_id])
    department = Department.find_by_id(params[:department_id])
    
    respond_to do |format|
      appeal = StudentDepartmentAppeal.find_or_create_by(:user => student, :department => department)
      appeal.update_attribute("comment", params[:comment])
      
      format.html { redirect_to root_path(id: params[:return_id]), notice: "Appeal saved." }
    end
  end
  
  def student_remove_appeal
    student = User.find_by_id(params[:student_id])
    course = Course.find_by_id(params[:course_to_remove])
    department = Department.find_by_id(params[:department_id])

    respond_to do |format|
      current_course = StudentDepartmentAppeal.find_by_user_id_and_course_id_and_department_id(student, course, department)
      current_course.destroy!
      
      format.html { redirect_to root_path(id: params[:return_id]), notice: "Course Removed."}
    end        
  end
  
  def student_remove_current_course
    student = User.find_by_id(params[:student_id])
    course = Course.find_by_id(params[:course_to_remove])

    respond_to do |format|
      current_course = CurrentCourse.find_by_user_id_and_course_id(student, course)
      current_course.destroy!
      deselect_current_course(student, course)
      
      format.html { redirect_to root_path(id: params[:return_id]), notice: "Course Removed."}
    end    
  end
  
  def deselect_current_course(student, course)
    recommended_course = RecommendedCourse.find_by_user_id_and_course_id(student, course)
    recommended_course.update_attribute(:selected, false) unless recommended_course.nil?
  end

  def select_current_course(student, course)
    recommended_course = RecommendedCourse.find_by_user_id_and_course_id(student, course)
    recommended_course.update_attribute(:selected, true)
  end

  def remove_recommended_course
    student = User.find_by_id(params[:student_id])
    course = Course.find_by_id(params[:course_id])

    respond_to do |format|
      recommended_course = RecommendedCourse.find_by_user_id_and_course_id(student, course)
      recommended_course.destroy!
      format.html { redirect_to edit_admin_student_path(student), notice: 'Deleted recommended course.' }
    end
  end

  def remove_taken_course
    student = User.find_by_id(params[:student_id])
    course = Course.find_by_id(params[:course_id])

    respond_to do |format|
      taken_course = TakenCourse.find_by_user_id_and_course_id(student, course)
      taken_course.destroy!
      format.html { redirect_to edit_admin_student_path(student), notice: 'Deleted taken course.' }
    end
  end

  def remove_current_course
    student = User.find_by_id(params[:student_id])
    course = Course.find_by_id(params[:course_id])

    respond_to do |format|
      current_course = CurrentCourse.find_by_user_id_and_course_id(student, course)
      current_course.destroy!
      
      deselect_current_course(student, course)
      
      format.html { redirect_to edit_admin_student_path(student), notice: 'Deleted current course.' }
    end
  end
  
  # PATCH/GET /students/1/active
  def activate
    student.update_attribute(:active, true)
    respond_to do |format|
      format.html { redirect_to admin_students_path }
      format.json { head :no_content }
    end
  end
  
  # PATCH/GET /students/1/deactivate
  def deactivate
    student.update_attribute(:active, false)
    respond_to do |format|
      format.html { redirect_to admin_students_path }
      format.json { head :no_content }
    end
  end
  
  # PATCH/GET /students/1/active_all
  def activate_all
    students.update_all(active: true)
    respond_to do |format|
      format.html { redirect_to admin_students_path }
      format.json { head :no_content }
    end
  end
  
  # PATCH/GET /students/1/deactivate_all
  def deactivate_all
    students.update_all(active: false)
    respond_to do |format|
      format.html { redirect_to admin_students_path }
      format.json { head :no_content }
    end
  end
    
    
  def update_selected
  	selected_ids = params[:student_ids].select{|key, value| if value == '1' then key end}.keys
  	selected_students = students.where(id: selected_ids)
  	if params[:commit] == "Activate Selected"
  		selected_students.update_all(active: true)
  	elsif params[:commit] == "Deactivate Selected"
  		selected_students.update_all(active: false)
  	end
  	respond_to do |format|
  	  format.html { redirect_to admin_students_path }
  	  format.json { head :no_content }
  	end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    student.destroy
    respond_to do |format|
      format.html { redirect_to admin_students_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = User.students.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:user).permit(:export_id, :first_name, :last_name, :preferred_name, :email, :current_grade_id, :registrar_notes, :next_grade_id, :active, :can_update, :student_id)
    end
    
    def current_course_params
      params.require(:user, :course).permit(:selected, :order)
    end
end
