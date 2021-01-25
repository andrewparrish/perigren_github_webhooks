module PerigrenGithubWebhooks
  class Review < ApplicationRecord
    belongs_to :pull_request, foreign_key: :perigren_pull_request_id

    scope :latest_reviews, ->(pull_request_id) { where(perigren_pull_request_id: pull_request_id).order(submitted_at: :desc) }
  end
end
