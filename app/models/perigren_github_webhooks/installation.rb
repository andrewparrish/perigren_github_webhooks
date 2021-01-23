module PerigrenGithubWebhooks
  class Installation < ApplicationRecord
    has_many :installations_repositories, class_name: 'InstallationsRepository'
    has_many :repositories, through: :installations_repositories, class_name: 'Repository'
    has_one :installation_setting
    has_one :slack_integration
    belongs_to :installer, class_name: 'GithubUser'
    has_many :github_users_installations, class_name: 'GithubUsersInstallations'
    has_many :github_users, through: :github_users_installations, class_name: 'GithubUser'
    has_many :slack_users, through: :slack_integration


    belongs_to :account, polymorphic: true

    scope :active, ->() { where(deleted: false) }

    def active?
      !deleted
    end

    def pull_requests
      repositories.flat_map(&:pull_requests)
    end

    def github_client_redis_key
      "token_pr_#{id}"
    end

    def redis_key
      "installation_#{id}"
    end
  end
end
