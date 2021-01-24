require 'perigren_github_webhooks'

RSpec.describe PerigrenGithubWebhooks::PullRequestEventService, type: :service do
  let(:test_data) { JSON.parse(File.read('spec/test_data/webhooks/event-pull-request.json')) }

  event = nil
  
  describe '#perform' do
    before do
      event = described_class.new(test_data).perform
    end

    it 'creates the pull request event' do
      expect(event.number).to eq 1
      expect(event.pull_request_id).to eq 205517141
      expect(event.installation_id).to eq 165203
      expect(event.sender_id).to eq 3136770
    end

    it 'creates the pull request' do
      pr = PerigrenGithubWebhooks::PullRequest.find(205517141)
      expect(pr.node_id).to eq test_data['pull_request']['node_id']
      expect(pr.title).to eq test_data['pull_request']['title']
      expect(pr.number).to eq test_data['pull_request']['number']
      expect(pr.repository_id).to eq test_data['repository']['id']
    end

    it 'creates the sender' do
      user = PerigrenGithubWebhooks::GithubUser.find(3136770)
      expect(user.node_id).to eq test_data['sender']['node_id']
      expect(user.avatar_url).to eq test_data['sender']['avatar_url']
      expect(user.site_admin).to be_falsey
    end
  end

  #describe 'hooks' do
  #  it 'calls the SynchronizePullRequestWorker' do
  #    expect(SynchronizePullRequestWorker).to receive(:perform_async).with(
  #      test_data['installation']['id'],
  #      test_data['pull_request']['id']
  #    )

  #    described_class.new(test_data).perform
  #  end
  #end
end
