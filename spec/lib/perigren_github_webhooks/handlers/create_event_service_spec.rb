require 'perigren_github_webhooks'

RSpec.describe PerigrenGithubWebhooks::Handlers::CreateEventService, type: :service do
  let(:test_data) { JSON.parse(File.read('spec/test_data/webhooks/event-create.json')) }
  
  describe '#perform' do
    event = nil
    before do
      event = described_class.new(test_data).perform
    end

    it 'creates a create event' do
      expect(event.ref).to eq 'simple-tag'
      expect(event.master_branch).to eq 'master'
      expect(event.pusher_type).to eq 'user'
    end

    it 'creates the repository' do
      repo = Repository.find(test_data['repository']['id'])
      expect(repo.node_id).to eq test_data['repository']['node_id']
      expect(repo.name).to eq 'Hello-World'
    end

    it 'creates the sender' do
      user = GithubUser.find(21031067)
      expect(user.login).to eq 'Codertocat'
      expect(user.site_admin).to be_falsey
    end
  end
end
