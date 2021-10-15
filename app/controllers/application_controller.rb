class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    

      rescue_from CanCan::AccessDenied do |exception|
        respond_to do |format|
          format.json { head :forbidden }
          format.html { redirect_to root_path, alert: exception.message }
        end
      end
    around_action :switch_locale
    include Pagy::Backend
    

    def switch_locale(&action)
        locale = params[:locale] || I18n.default_locale
        I18n.with_locale(locale, &action)
    end

    def default_url_options
        { locale: I18n.locale }
      end

      private
    

end
