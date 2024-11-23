# app/controllers/avo/application_controller.rb
module Avo
  class ApplicationController < BaseApplicationController
    include Authentication

    # we are prepending the action to ensure it will be fired very early on in the request lifecycle
    prepend_before_action :require_authentication
  end
end
