require 'rails_helper'

RSpec.describe PerigrenGithubWebhooks::InstallationRepositoryEventService, type: :service do
  let(:test_data) { JSON.parse(File.read('spec/test_data/webhooks/event-integration-installation-repository-added.json')) }

  describe '#perform' do
    event = nil

    before do
      event = described_class.new(test_data).perform
    end

    it 'creates the installation repository event' do
      expect(event.action).to eq 'added'
      expect(event.perigren_installation_id).to equal 165203
      expect(event.sender_id).to eq 3136770
      expect(event.sender_type).to eq 'PerigrenGithubWebhooks::GithubUser'
      expect(event.repositories_added).to eq [142814010]
    end

    it 'creates the installation' do
      installation = PerigrenGithubWebhooks::Installation.find(165203)
      expect(installation.account_id).to equal(3136770)
      expect(installation.app_id).to eq 11355
    end

    it 'creates the sender' do
      sender = PerigrenGithubWebhooks::GithubUser.find(3136770)
      expect(sender.login).to eq 'andrewparrish'
    end

    it 'creates the repositories' do
      repo = PerigrenGithubWebhooks::Repository.find(142814010)
      expect(repo.name).to eq 'webhooks-test-server'
    end

    it 'creates the association' do
      assoc = PerigrenGithubWebhooks::InstallationsRepository.find_by(perigren_repository_id: 142814010, perigren_installation_id: 165203)
      expect(assoc).not_to be_nil
    end
  end
end
