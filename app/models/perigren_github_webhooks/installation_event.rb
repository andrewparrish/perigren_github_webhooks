module PerigrenGithubWebhooks
  class InstallationEvent < ApplicationRecord
    belongs_to :sender, polymorphic: true
  end
end
