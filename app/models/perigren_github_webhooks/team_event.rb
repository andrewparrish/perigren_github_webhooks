module PerigrenGithubWebhooks
  class TeamEvent < ApplicationRecord
    belongs_to :sender, polymorphic: true
  end
end
