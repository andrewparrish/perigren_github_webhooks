module PerigrenGithubWebhooks
  class PullRequest < ApplicationRecord
    has_many :reviews, foreign_key: :perigren_review_id
    has_many :review_comments
    belongs_to :repository, foreign_key: :perigren_repository_id
    belongs_to :creator, polymorphic: true

    scope :for_installation, ->(installation_id) { where(repository_id: InstallationsRepository.where(installation_id: installation_id).select(:repository_id).distinct.map(&:repository_id)) }

    def creator_name
      @creator_name ||= creator.user.name || creator.login
    end

    def open?
      state == 'open'
    end

    def unaddressed_feedback?
      review_comments.reject(&:addressed?).any?
    end

    def all_feedback_addressed?
      review_comments.any? && !unaddressed_feedback?
    end

    def reviewed?
      reviews.count > 0
    end
  end
end
