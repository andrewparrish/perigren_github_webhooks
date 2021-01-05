class PullRequest < ApplicationRecord
  HOURS_STALE = 24

  has_many :reviews
  has_many :review_comments
  belongs_to :repository
  belongs_to :creator, polymorphic: true

  scope :open, -> { where(state: 'open').order(last_touched_at: :asc) }
  scope :for_installation, ->(installation_id) { where(repository_id: InstallationsRepository.where(installation_id: installation_id).select(:repository_id).distinct.map(&:repository_id)) }

  after_create :trigger_opened_slack_notification

  def set_hours_stale(hours)
    @hours_stale = hours
  end

  def addressed!
    review_comments.unaddressed.group_by(&:github_user_id).each do |_user_id, comments|
      MarkAddressedNotificationWorker.perform_async(self.id, comments.first.id)
      SlackWorkers::MarkAddressedSlackWorker.perform_async(self.id, comments.first.id)
      comments.each { |comment| comment.update(addressed: true) }
    end
    self.update(last_touched_at: Time.now)
  end

  def creator_name
    @creator_name ||= creator.user.name || creator.login
  end

  def open?
    state == 'open'
  end

  def new?
    created_at > (DateTime.now  - 1.hours)
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

  def stale
    return false unless open?
    (last_touched_at + (@hours_stale || HOURS_STALE).hours) < DateTime.now
  end

  def info_chips
    ChipService.new(self).chips
  end

  private

  def trigger_opened_slack_notification
    PullRequestNotificationWorker.perform_async(self.id, "PrOpened")
  end
  
  alias_method :stale?, :stale
end
