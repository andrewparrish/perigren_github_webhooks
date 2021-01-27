require 'rails_helper'
require 'perigren_github_webhooks'

RSpec.describe PerigrenGithubWebhooks::CommitCommentEventService, type: :service do
  let(:test_data) { JSON.parse(File.read('spec/test_data/webhooks/event-commit-comment.json')) }

  describe '#perform' do
    event = nil

    before do
      event = described_class.new(test_data).perform
    end

    it 'creates the commit comment event' do
      expect(event.action).to eq('created')
      expect(event.sender_id).to eq(test_data['sender']['id'])
      expect(event.perigren_repository_id).to eq(test_data['repository']['id'])
    end

    it 'creates the repository' do
      repo = PerigrenGithubWebhooks::Repository.find(test_data['repository']['id'])
      expect(repo.name).to eq 'Hello-World'
      expect(repo.node_id).to eq test_data['repository']['node_id']
    end

    it 'creates the repository_comment' do
      comment = PerigrenGithubWebhooks::RepositoryComment.find(test_data['comment']['id'])
      expect(comment.node_id).to eq test_data['comment']['node_id']
      expect(comment.body).to eq test_data['comment']['body']
    end

    it 'creates the sender' do
      user = PerigrenGithubWebhooks::GithubUser.find(21031067)
      expect(user.login).to eq('Codertocat')
      expect(user.node_id).to eq(test_data['sender']['node_id'])
    end
  end
end
