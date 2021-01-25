require 'perigren_github_webhooks'

RSpec.describe PerigrenGithubWebhooks::RepositoryEventService, type: :service do
  let(:test_data) { JSON.parse(File.read('spec/test_data/webhooks/event-repository-created.json')) }

  describe '#perform' do
    event = nil

    before do
      event = described_class.new(test_data).perform
    end

    it 'creates the repository created event' do
      expect(event.action).to eq 'created'
      expect(event.perigren_installation_id).to eq test_data['installation']['id']
    end

    it 'creates the repo' do
      repo = PerigrenGithubWebhooks::Repository.find(test_data['repository']['id'])
      expect(repo.name).to eq 'webhooks-test-server'
    end
  end
end
