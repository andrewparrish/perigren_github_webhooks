module PerigrenGithubWebhooks
  class InstallationGithubUsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_installation
    before_action :check_owner

    def index
      render json: @installation.github_users
    end

    private

    def is_owner?
      @installation.installer_id == current_user.github_user.id
    end

    def set_installation
      @installation = Installation.find(params[:installation_id]) 
    end
  end
end
