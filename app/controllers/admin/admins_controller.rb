class Admin::AdminsController < Admin::BaseAdminController
  before_action :set_admin, only: [:update]
    
  # !group Exposures
  	  
    # The current admin.
    # return [User]
    expose(:admin){ admins.find_by_id(params[:id]) }
    
  # GET /admins
  # GET /admins.json
  def index
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = User.admins.new(admin_params)
    @admin.password = 'Password01'
    respond_to do |format|
      if @admin.save
        format.html { redirect_to edit_admin_admin_path(@admin), notice: 'admin was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to edit_admin_admin_path(@admin), notice: 'admin was successfully updated.' }
        format.json { render action: 'show', status: :updated, location: @admin }
        #format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    admin.destroy
    respond_to do |format|
      format.html { redirect_to admin_admins_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = User.admins.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:user).permit(:export_id, :first_name, :last_name, :preferred_name, :email, :current_grade_id, :next_grade_id, :active, :can_update)
    end
end
