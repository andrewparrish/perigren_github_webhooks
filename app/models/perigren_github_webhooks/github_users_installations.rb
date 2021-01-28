module PerigrenGithubWebhooks
  class GithubUsersInstallations < ApplicationRecord
    belongs_to :perigren_github_user, class_name: 'GithubUser', foreign_key: :perigren_github_user_id
    belongs_to :perigren_installation, class_name: 'Installation', foreign_key: :perigren_installation_id
  end
end
