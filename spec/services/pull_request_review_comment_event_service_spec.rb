require 'rails_helper'

RSpec.describe PerigrenGithubWebhooks::PullRequestReviewCommentEventService, type: :service do
  let(:test_data) { JSON.parse(File.read('spec/test_data/webhooks/event-pull-request-review-comment.json')) }

  describe '#perform' do
    event = nil

    before do
    #  allow(FeedbackLeftNotificationWorker).to receive(:perform_async)
      event = described_class.new(test_data).perform
    end

    it 'creates the pull request review comment event' do
      expect(event.action).to eq 'created'
      expect(event.perigren_review_comment_id).to eq 191908831
      expect(event.perigren_pull_request_id).to eq 191568743
      expect(event.perigren_repository_id).to eq 135493233
      expect(event.sender_id).to eq 21031067
      expect(event.sender_type).to eq 'PerigrenGithubWebhooks::GithubUser'
    end

    it 'creates the review comment for the event' do
      comment = PerigrenGithubWebhooks::ReviewComment.find(191908831)
      expect(comment.perigren_pull_request_id).to eq 191568743
      expect(comment.node_id).to eq test_data['comment']['node_id']
    end

    it 'creates the pull request for the event' do
      pr = PerigrenGithubWebhooks::PullRequest.find(191568743)
      expect(pr.node_id).to eq test_data['pull_request']['node_id']
    end

    it 'creates the sender' do
      user = PerigrenGithubWebhooks::GithubUser.find(21031067)
      expect(user.login).to eq 'Codertocat'
    end

    it 'creates the repository' do
      repo = PerigrenGithubWebhooks::Repository.find(135493233)
      expect(repo.name).to eq 'Hello-World'
    end

  end

  #describe 'background jobs calls' do
  #  it 'calls the feedback left worker' do
  #    expect(FeedbackLeftNotificationWorker).to receive(:perform_async).with(
  #      191568743, 21031067
  #    )

  #    described_class.new(test_data).perform
  #  end
  #end
end
