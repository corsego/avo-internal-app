# app/controllers/avo/application_controller.rb
module Avo
  class ApplicationController < BaseApplicationController
    include Authentication

    # we are prepending the action to ensure it will be fired very early on in the request lifecycle
    prepend_before_action :require_authentication

    before_action :ensure_admin

    private

    def ensure_admin
      unless Current.user&.admin?
        redirect_to main_app.root_path, alert: "You are not authorized to access this page."
      end
    end
  end
end
