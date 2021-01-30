module PerigrenGithubWebhooks
  class ApplicationController < ActionController::Base
    # TODO: See how this works w/ a real application
    skip_before_action :verify_authenticity_token
  end
end
