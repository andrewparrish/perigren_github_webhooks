module PerigrenGithubWebhooks
  class PullRequestReviewEvent < ApplicationRecord
    belongs_to :sender, polymorphic: true
  end
end
