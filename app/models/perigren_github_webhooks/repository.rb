module PerigrenGithubWebhooks
  class Repository < ApplicationRecord
    has_many :installations_repositories, class_name: 'InstallationsRepository'
    has_many :installations, through: :installations_repositories, class_name: 'Installation'
    has_many :pull_requests, class_name: 'PullRequest'

    belongs_to :owner, polymorphic: true
  end
end
