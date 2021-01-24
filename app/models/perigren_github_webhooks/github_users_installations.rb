module PerigrenGithubWebhooks
  class GithubUsersInstallations < ApplicationRecord
    belongs_to :github_user, class_name: 'GithubUser'
    belongs_to :installation, class_name: 'Installation'
  end
end
