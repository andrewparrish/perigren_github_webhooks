require 'perigren_github_webhooks'

RSpec.describe PerigrenGithubWebhooks::Handlers::StatusEventService, type: :service do
  let(:test_data) { JSON.parse(File.read('spec/test_data/webhooks/event-status.json')) }

  describe '#perform' do
    before do
      described_class.new(test_data).perform
    end

    it 'creates the event model' do
      event = StatusEvent.find(test_data['id'])
      expect(event.name).to eq 'Codertocat/Hello-World'
      expect(event.sender_id).to eq test_data['sender']['id']
    end

    it 'creates the commit' do
      commit = Commit.find_by(sha: test_data['commit']['sha'])
      expect(commit.node_id).to eq test_data['commit']['node_id']
    end

    it 'creates the committer' do
      user = GithubUser.find(19864447)
      expect(user.login).to eq 'web-flow'
    end

    it 'creates the sender' do
      user = GithubUser.find(test_data['sender']['id'])
      expect(user.login).to eq 'Codertocat'
    end
  end
end
