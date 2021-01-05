class ReviewComment < ApplicationRecord
  belongs_to :pull_request
  belongs_to :github_user

  scope :unaddressed, ->() { where(addressed: false) }

  before_save :update_addressed!, if: :will_save_change_to_position?

  def self.update_from_request(api_data, pull_request)
    user_data = api_data['user'].select do |k, _v|
      GithubUser.column_names.include?(k) && k != 'type'
    end
    GithubUser.find_or_create_by(user_data)
    comment = find(api_data['id']) || comment.new(pull_request_id: pull_request.id).tap { |c| c.id = api_data['id'] }
    comment.update(update_hash(api_data))
  end

  def self.update_hash(data)
    hash = data.select { |k, _v| self.column_names.include? k }
    hash['github_user_id'] = data['user']['id']
    hash
  end

  private

  def update_addressed!
    self.addressed = true if position.nil? and !position_was.nil?
  end
end
