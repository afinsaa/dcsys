class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index
    @pagy, @students = pagy(Student.accessible_by(current_ability))

  end

  # GET /students/1 or /students/1.json
  def show
    require 'rqrcode'
    stdnt = Student.find(params[:id])
    qrcode = RQRCode::QRCode.new(stdnt.sid)

    # NOTE: showing with default options specified explicitly
    png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 120
    )
    File.open(Rails.root.join('app/assets/images', 'tmp', "tmpqr_#{current_user.id}.png"), 'wb') do |f|
      f.write(png.to_s)
    end
    # IO.binwrite(Rails.root.join('app/assets/images', 'tmp', 'tmpqr.png'), png.to_s)
    # IO.binwrite("/tmp/#{stdnt.id}-qrcode.png", png.to_s)

  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def import
      
    require 'roo'
      puts 'Importing Data'
      file = params[:file]

      students = []
      data = Roo::Spreadsheet.open(file.path) # open spreadsheet
      
      
      created_student_counter = 0
      
      p "data row: #{data.count}"
      data.each_with_index do |row, idx |
        next if idx < 1 # skip row till the table data
        # create hash from headers and cells
        # user_data = Hash[[headers, row].transpose]
        p "row: #{row}, idx: #{idx}"
        
          
        if /\A\d+\z/.match(row[0].to_s)
          
          student = Student.new
          student.sid = row[0]
          student.name = row[1]
          student.tawaklna_s = row[2]
          student.school_id = current_user.school_id

          students << student
          created_student_counter += 1

        end
      end

      if students.count > 0
        results = Student.import students, validate: true, track_validation_failures: true, on_duplicate_key_update: [:sid]

        results.failed_instances.each do |e|
          
          e.errors.full_messages.each do |m|
            p "error message: #{m}"
            flash[:alert] = "#{m}"
          end

          # valiation_error += 1

        end
      end
      redirect_to students_url, notice: t('portal.student.import_noor_msg', created: created_student_counter)
 end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:sid, :name, :tawaklna_s, :school_id)
    end
end
