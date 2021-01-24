module PerigrenGithubWebhooks
  class TeamAddEvent < ApplicationRecord
    belongs_to :sender, polymorphic: true
  end
end
