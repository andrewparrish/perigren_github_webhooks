module PerigrenGithubWebhooks
  class PullRequestEvent < ApplicationRecord
    belongs_to :sender, polymorphic: true
  end
end
