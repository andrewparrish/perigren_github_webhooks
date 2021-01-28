require 'rails_helper'

RSpec.describe PerigrenGithubWebhooks::PullRequestReviewEventService, type: :service do

  let(:test_data) { JSON.parse(File.read('spec/test_data/webhooks/event-pull-request-review-submitted.json')) }
  
  describe '#perform' do
    event = nil

    before do
      event = described_class.new(test_data).perform
    end

    it 'creates the pull request review event' do
      expect(event.action).to eq 'submitted'
      expect(event.perigren_review_id).to eq test_data['review']['id']
      expect(event.perigren_installation_id).to eq test_data['installation']['id']
    end

    it 'creates the review model' do
      review = PerigrenGithubWebhooks::Review.find(test_data['review']['id'])
      expect(review.node_id).to eq test_data['review']['node_id']
      expect(review.perigren_pull_request_id).to eq test_data['pull_request']['id']
    end

    it 'creates the sender model' do
      user = PerigrenGithubWebhooks::GithubUser.find(test_data['sender']['id'])
      expect(user.login).to eq 'andrewparrish'
      expect(user.node_id).to eq test_data['sender']['node_id']
    end

    it 'creates the pull request model' do
      pr = PerigrenGithubWebhooks::PullRequest.find(test_data['pull_request']['id'])
      expect(pr.node_id).to eq test_data['pull_request']['node_id']
    end

    it 'createst he repository model' do
      repo = PerigrenGithubWebhooks::Repository.find(test_data['repository']['id'])
      expect(repo.node_id).to eq test_data['repository']['node_id']
    end
  end
end
