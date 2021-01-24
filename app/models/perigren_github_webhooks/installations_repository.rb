module PerigrenGithubWebhooks
  class InstallationsRepository < ApplicationRecord
    belongs_to :installation, class_name: 'Installation'
    belongs_to :repository, class_name: 'Repository'

    validates_uniqueness_of :repository_id, scope: :installation_id
  end
end
