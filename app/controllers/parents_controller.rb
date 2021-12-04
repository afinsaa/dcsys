class ParentsController < ApplicationController
    
    before_action :set_parent, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  # GET /parents or /parents.json
  def index
    @pagy, @parents = pagy(Parent.accessible_by(current_ability))

  end

  # GET /parents/1 or /parents/1.json
  def show
    
    @parent = Parent.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      
      format.pdf { render :layout => false }
    end

  end

  # GET /parents/new
  def new
    @parent = Parent.new
  end

  # GET /parents/1/edit
  def edit
  end

  # POST /parents or /parents.json
  def create
    if current_user.has_role? :Admin
      @parent = Parent.new(admin_parent_params)
    else 
      @parent = Parent.new(parent_params)
      @parent.school_id = current_user.school_id
    end

    respond_to do |format|
      if @parent.save

        
        format.html { redirect_to @parent, notice: "parent was successfully created." }
        format.json { render :show, status: :created, location: @parent }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parents/1 or /parents/1.json
  def update
    respond_to do |format|
      if @parent.update(parent_params)
        format.html { redirect_to @parent, notice: "parent was successfully updated." }
        format.json { render :show, status: :ok, location: @parent }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parents/1 or /parents/1.json
  def destroy
    @parent.destroy
    respond_to do |format|
      format.html { redirect_to parents_url, notice: "parent was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def delete_all
    parent.accessible_by(current_ability).delete_all
    redirect_to parents_url, alert: t('portal.forms.delete_all.success')
  end


  

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parent
      @parent = Parent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_parent_params
      params.require(:parent).permit(:user_id, :student_id)
    end

    def parent_params
      params.require(:parent).permit(:user_id, :student_id)
    end
end
