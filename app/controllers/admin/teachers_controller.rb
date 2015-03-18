class Admin::TeachersController < Admin::BaseAdminController
  before_action :set_teacher, only: [:update]
    
  # !group Exposures
  	  
    # The current teacher.
    # return [User]
    expose(:teacher){ teachers.find_by_id(params[:id]) }
    
  # GET /teachers
  # GET /teachers.json
  def index
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show
  end

  # GET /teachers/new
  def new
  end

  # GET /teachers/1/edit
  def edit
  end

  # POST /teachers
  # POST /teachers.json
  def create
    @teacher = User.teachers.new(teacher_params)
    @teacher.password = 'Password01'
    respond_to do |format|
      if @teacher.save
        format.html { redirect_to admin_teachers_path, notice: 'teacher was successfully created.' }
        format.json { render action: 'show', status: :created, location: @teacher }
      else
        format.html { render action: 'new' }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teachers/1
  # PATCH/PUT /teachers/1.json
  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to admin_teacher_path(@teacher), notice: 'teacher was successfully updated.' }
        format.json { render action: 'show', status: :updated, location: @teacher }
        #format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    teacher.destroy
    respond_to do |format|
      format.html { redirect_to admin_teachers_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = User.teachers.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.require(:user).permit(:export_id, :first_name, :last_name, :preferred_name, :email, :current_grade_id, :next_grade_id, :active, :can_update)
    end
end
