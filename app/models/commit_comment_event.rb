class CommitCommentEvent < ApplicationRecord
  belongs_to :sender, polymorphic: true
  has_one :repository
  has_one :repository_comment
end
