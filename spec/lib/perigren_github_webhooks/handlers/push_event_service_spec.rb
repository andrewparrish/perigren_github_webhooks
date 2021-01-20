require 'perigren_github_webhooks'

RSpec.describe PerigrenGithubWebhooks::Handlers::PushEventService, type: :service do
  let(:test_data) { JSON.parse(File.read('spec/test_data/webhooks/event-push.json')) }


  describe '#perform' do
    event = nil

    before do
      event = described_class.new(test_data).perform
    end

    it 'creates the push event' do
      expect(event.ref).to eq 'refs/tags/simple-tag'
      expect(event.before).to eq test_data['before']
      expect(event.pusher).to eq test_data['pusher']
      expect(event.commits).to eq ['1234']
    end

    it 'creates the repository' do
      repo = Repository.find(test_data['repository']['id'])
      expect(repo.node_id).to eq test_data['repository']['node_id'] 
      expect(repo.name).to eq 'Hello-World'
    end

    it 'creates the sender' do
      user = GithubUser.find(test_data['sender']['id'])
      expect(user.login).to eq 'Codertocat'
      expect(user.node_id).to eq test_data['sender']['node_id']
    end
  end
end
