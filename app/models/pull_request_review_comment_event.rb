class PullRequestReviewCommentEvent < ApplicationRecord
  belongs_to :sender, polymorphic: true
end
