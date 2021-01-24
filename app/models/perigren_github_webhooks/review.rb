module PerigrenGithubWebhooks
  class Review < ApplicationRecord
    belongs_to :pull_request

    scope :latest_reviews, ->(pull_request_id) { where(pull_request_id: pull_request_id).order(submitted_at: :desc) }
  end
end
