class GithubUser < ApplicationRecord
  has_one :user, foreign_key: 'uid'
  has_many :github_users_installations, class_name: 'GithubUsersInstallations'
  has_many :github_users_organizations, class_name: 'GithubUsersOrganizations'
  has_many :installations, through: :github_users_installations, class_name: 'Installation'
  has_many :organizations, through: :github_users_organizations, class_name: 'Organization'

  def self.create_or_update_from_request(data)
    user_data = data.select do |k, _v|
      GithubUser.column_names.include?(k) && k != 'type'
    end

    if GithubUser.exists?(user_data['id'])
      GithubUser.find(user_data['id']).tap do |u|
        u.update(user_data)
      end
    else
      GithubUser.create(user_data)
    end
  end
end
