class Admin::CoursesController < Admin::BaseAdminController
  before_action :set_course, only: [:update, :destroy]
  require 'will_paginate/array'

  # !group Exposures
      
  # The current course.
  # return [Course]
  expose(:course)
    
  # GET /courses
  # GET /courses.json
  def index
    # @courses = Course.order(:id)
    # @courses.each do |course|
    #   logger.info ">>>> course : #{course.id} #{course.name}"
    # end
  end
  
  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @courses_by_grade = courses
  end

  # GET /courses/1/edit
  def edit
    @courses_by_grade = Course.find_courses_by_grade_and_active(course.grade, true)
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to edit_admin_course_path(@course), notice: 'Course was successfully created.' }
        format.json { render action: 'show', status: :created, location: @course }
      else
        format.html { render action: 'new' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to edit_admin_course_path(@course), notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: course.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/GET /courses/1/active
  def activate
    course.update_attribute(:active, true)
    respond_to do |format|
      format.html { redirect_to admin_courses_path }
      format.json { head :no_content }
    end
  end
  
  # PATCH/GET /courses/1/deactivate
  def deactivate
    course.update_attribute(:active, false)
    respond_to do |format|
      format.html { redirect_to admin_courses_path }
      format.json { head :no_content }
    end
  end

  # PATCH/GET /courses/1/active
  def activate_all
    courses.update_all(active: true)
    respond_to do |format|
      format.html { redirect_to admin_courses_path }
      format.json { head :no_content }
    end
  end
  
  # PATCH/GET /courses/1/deactivate
  def deactivate_all
    courses.update_all(active: false)
    respond_to do |format|
      format.html { redirect_to admin_courses_path }
      format.json { head :no_content }
    end
  end
    
  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    course.destroy
    respond_to do |format|
      format.html { redirect_to admin_courses_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :description, :code, :grade_id, :department_id, :main_course_id, :active, :errors)
    end
end
