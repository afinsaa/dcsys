class QrCodesController < ApplicationController
  before_action :set_qr_data, only: :create
  
  def index
  end


  def create
    # @log = Log.new(log_params)
    user = current_user
    respond_to do |format|
      if (Student.exists?(qrcode: @qr_data) )
        student = Student.where(qrcode: @qr_data, school_id: current_user.school_id).first
        @log = Log.create(student: student, sid: student.sid, user: user, tawaklna_s: student.tawaklna_s)
        @tawaklnaClass = ""
        case student.tawaklna_s
        when "immune"
          @tawaklnaClass = "green"
        when "infected"
          @tawaklnaClass = "brown"
        when "exposed"
          @tawaklnaClass = "yellow"
        else
          @tawaklnaClass = "grey"
        end
        format.html { redirect_to log_path(@log), notice: "Log was successfully created." }
        format.json { render :show, status: :created, location: @log }
      else
        flash.now[:alert] = "Student was not found"
        format.html { render :index, status: 404 }
        format.json { render json: "Student was not found", status: 404 }
      end
    end
    
    # user = current_user
    # if (Student.exists?(qrcode: @qr_data) )
    #   student = Student.where(qrcode: @qr_data, school_id: current_user.school_id).first
    #   qr_code = Log.create(student: student, user: user, tawaklna_s: student.tawaklna_s)
    #   @tawaklnaClass = ""
    #   case student.tawaklna_s
    #   when "ammune"
    #     @tawaklnaClass = "green"
    #   when "infected"
    #     @tawaklnaClass = "brown"
    #   else
    #     @tawaklnaClass = "green"
    #   end
    #   redirect_to log_path(qr_code)
    # else
    #   render :index, error: 'Student does not exist'
      
    # end
    

    
  end

  private
  
  # Only allow a list of trusted parameters through.
  def log_params
    params.require(:log).permit(:tawaklna_s, :student_id, :user_id)
  end

  def set_qr_data
    qr_code_params = JSON.parse(params[:qr_code_json_data]).with_indifferent_access

    @qr_data = qr_code_params[:qr_data]
  end
end
