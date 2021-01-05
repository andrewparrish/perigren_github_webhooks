class GithubUsersOrganizations < ApplicationRecord
  belongs_to :github_user, class_name: 'GithubUser'
  belongs_to :organization, class_name: 'Organization'
end
