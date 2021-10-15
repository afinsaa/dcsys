class ErrorsController < ApplicationController
    def routing
      redirect_to root_path, alert: t('errors.page_not_found')
    end
end