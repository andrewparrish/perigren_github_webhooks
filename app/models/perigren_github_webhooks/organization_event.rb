module PerigrenGithubWebhooks
  class OrganizationEvent < ApplicationRecord
    belongs_to :sender, polymorphic: true
  end
end
