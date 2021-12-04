class StudentReportsController < ApplicationController


    def show
        
        @pagy, @st_reports = pagy(StudentReport.accessible_by(current_ability).order( 'student_reports.id DESC' ))
        @student_report = StudentReport.new
        @student = Student.find(params[:id])
        respond_to do |format|
        format.html 
        format.pdf { render :layout => false }
        end
    end

    # GET /parents/new
    def new
        @student_report = StudentReport.new
    end

    # POST /parents or /parents.json
    def create
        
        @student_report = StudentReport.new(student_report_params)
        # @student_report.school_id = current_user.school_id
        
        @student_report.user_id = current_user.id
        @student = Student.find(@student_report.student_id)

        respond_to do |format|
        if @student_report.save

            
            format.html { redirect_to  student_report_path(@student), notice: "student_report was successfully created." }
            format.json { render :show, status: :created, location: @student }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @student_report.errors, status: :unprocessable_entity }
        end
        end
    end

private
    

    # Only allow a list of trusted parameters through.
    def student_report_params
      params.require(:student_report).permit(:note, :ntype, :student_id, :user_id)
    end

end
