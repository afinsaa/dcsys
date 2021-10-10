class DashboardController < ApplicationController
    require 'date'
    def index

      # if current_user.school_id == nil
      #   redirect_to dashboard_noschool_path
      # else

        @logs = Log.accessible_by(current_ability).count
        # @visitors_count = Botad.where(user_type: 16).count
        @users = User.accessible_by(current_ability).count
        @students_count = Student.accessible_by(current_ability).count
        # @teachers_count = Teacher.accessible_by(current_ability).count
        # @classes_count = Classs.accessible_by(current_ability).count
        # @subjects_count = Subject.accessible_by(current_ability).count
        # @complaints = Complaint.accessible_by(current_ability).count
        log_count = Log.accessible_by(current_ability).count

        if current_user.has_role? :Admin
            p "you are admin"
          daily_attendes = Log.where('created_at >= ? ', Date.today.beginning_of_day)
          monthly_counts = Log.select("DATE_FORMAT( created_at, '%M') as month, COUNT(id) as total ").group("month")
          healthy_students = Log.where(tawaklna_s: 'healthy').count
          sick_students = Log.where(tawaklna_s: 'sick').count

        else
          
          daily_attendes = Log.where('created_at >= ? and user_id = ?', Date.today.beginning_of_day, current_user.id)
          monthly_counts = Log.select("DATE_FORMAT( created_at, '%M') as month, COUNT(id) as total ").where(user_id: current_user.id).group("month")
          healthy_students = Log.where(tawaklna_s: 'healthy', user_id: current_user.id).count
          sick_students = Log.where(tawaklna_s: 'sick', user_id: current_user.id).count

        end

        @daily_attendes_count = daily_attendes.count


        all_attendes = Log.accessible_by(current_ability).group_by{ |u| u.created_at.month }

        @months = []
        @months_total = []
        monthly_counts.each do |mc|
          @months.append(mc.month)
          @months_total.append(mc.total)
        end


      

        @attending = ((healthy_students*1.00/(healthy_students*1.00 + sick_students*1.00)))* 100
        @attending = @attending.nan? ? 0.0 : @attending
      # end

    

    end

  def noschool

  end

    def show
    end

    def redirect_to_dashboard
        redirect_to dashboard_index_url, locale: :ar
      end
  end