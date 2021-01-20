module PerigrenGithubWebhooks
  class Organization < ApplicationRecord
    has_many :github_users_organizations, class_name: 'GithubUsersOrganizations'
    has_many :github_users, through: :github_users_organizations, class_name: 'GithubUser'
  end
end
