module PerigrenGithubWebhooks
  class InstallationsRepository < ApplicationRecord
    belongs_to :installation, class_name: 'Installation', foreign_key: :perigren_installation_id
    belongs_to :repository, class_name: 'Repository', foreign_key: :perigren_repository_id

    validates_uniqueness_of :perigren_repository_id, scope: :perigren_installation_id
  end
end
