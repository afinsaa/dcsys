class LogsController < ApplicationController
  # before_action :set_log, only: %i[ show edit update destroy ]
  before_action :set_qr_data, only: :create
  # GET /logs or /logs.json
  load_and_authorize_resource
  
  def index

    @pagy, @logs = pagy(Log.accessible_by(current_ability))
    
    respond_to do |format|
      format.html 
      format.pdf { render :layout => false }
    end

  end

  def export
    require 'date'
    if params[:search_val].blank?
      @logs = Log.accessible_by(current_ability)
      if @logs.count == 0
        flash[:alert] = t('portal.logs.no_result')
        redirect_to logs_url
      else
        respond_to do |format|
          format.pdf { render :layout => false }
        end
      end
    else
      search_val = params[:search_val]
      if search_val.valid_date?
        @logs = Log.search(search_val).accessible_by(current_ability)
        if @logs.count == 0
          flash[:alert] = t('portal.logs.no_result')
          redirect_to logs_url
        else
          respond_to do |format|
            format.pdf { render :layout => false }
          end
        end
      else
        flash[:alert] = t('portal.logs.no_result')
        redirect_to logs_url
      end
    end
    
    
    
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

  def show
    @log = Log.find(params[:id])

    @tawaklnaClass = ""
    
      case @log.student.tawaklna_s
      when "immune"
        @tawaklnaClass = "green"
      when "infected"
        @tawaklnaClass = "brown"
      when "exposed"
        @tawaklnaClass = "yellow"
      else
        @tawaklnaClass = "grey"
      end

      respond_to do |format|
        format.html # show.html.erb
        format.pdf { render :layout => false }
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

  def download
    require 'csv'
    require 'prawn'

    file = "#{Rails.root}/public/assets/reports/logs_data.csv"
    # pdf = WickedPdf.new.pdf_from_string('<h1>Hello There!</h1>', {temp_path: "your path here")
    
    pdf = Prawn::Document.new
    pdf.text(file)
    
    table = Log.all;0 # ";0" stops output.  Change "User" to any model.
    if Log.all.count > 0
      csv_string = CSV.open( file, 'w' ) do |writer|
        writer << table.first.attributes.map { |a,v| a }
        table.each do |s|
          writer << s.attributes.map { |a,v| v }
        end
      end
    end

    
    # pdf.render_file('csv.pdf')
    
    send_data pdf.render, filename: "cvs.pdf",type: "application/pdf"

    # send_data(csv_string,
    #   :type => 'text/csv; charset=utf-8; header=present',
    #   :filename => file)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    
    def valid_date?( str, format="%m-%d-%Y" )
      Date.strptime(str,format) rescue false
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
