class LogsController < ApplicationController
  # before_action :set_log, only: %i[ show edit update destroy ]
  before_action :set_qr_data, only: :create
  # GET /logs or /logs.json
  def index
    

    @pagy, @logs = pagy(Log.accessible_by(current_ability))
  end

  

  # GET /logs/new
  def new
    @log = Log.new
  end

  # GET /logs/1/edit
  def edit
  end

  # POST /logs or /logs.json
  def create
    # @log = Log.new(log_params)

    # respond_to do |format|
    #   if @log.save
    #     format.html { redirect_to @log, notice: "Log was successfully created." }
    #     format.json { render :show, status: :created, location: @log }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @log.errors, status: :unprocessable_entity }
    #   end
    # end
    
    user = current_user
    if (Student.exists?(sid: @qr_data) )
      student = Student.where(sid: @qr_data, school_id: current_user.school_id).first
      qr_code = Log.create(student: student, user: user, tawaklna_s: student.tawaklna_s)
      @tawaklnaClass = ""
      case student.tawaklna_s
      when "clear"
        @tawaklnaClass = "green"
      when "infected"
        @tawaklnaClass = "brown"
      else
        @tawaklnaClass = "green"
      end
      redirect_to log_path(qr_code)
    else
      redirect_to log_path(nil), error: 'Student does not exist'
    end
    

    
  end

  def show
    @log = Log.find(params[:id])

    @tawaklnaClass = ""
    
      case @log.student.tawaklna_s
      when "clear"
        @tawaklnaClass = "green"
      when "infected"
        @tawaklnaClass = "brown"
      else
        @tawaklnaClass = "green"
      end
  end

  # PATCH/PUT /logs/1 or /logs/1.json
  def update
    # respond_to do |format|
    #   if @log.update(log_params)
    #     format.html { redirect_to @log, notice: "Log was successfully updated." }
    #     format.json { render :show, status: :ok, location: @log }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @log.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /logs/1 or /logs/1.json
  def destroy
    # @log.destroy
    # respond_to do |format|
    #   format.html { redirect_to logs_url, notice: "Log was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def log_params
      params.require(:log).permit(:tawaklna_s, :student_id, :user_id)
    end

    def set_qr_data
      qr_code_params = JSON.parse(params[:qr_code_json_data]).with_indifferent_access
  
      @qr_data = qr_code_params[:qr_data]
    end
end
