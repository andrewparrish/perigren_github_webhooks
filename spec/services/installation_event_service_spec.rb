require 'rails_helper'
require 'perigren_github_webhooks'

RSpec.describe PerigrenGithubWebhooks::InstallationEventService, type: :service do
  let(:test_event_data) { JSON.parse(File.read('spec/test_data/webhooks/event-installation-created.json')) }
  let(:test_org_data) { JSON.parse(File.read('spec/test_data/webhooks/event-organization-installation.json')) }
  let(:test_delete_data) { JSON.parse(File.read('spec/test_data/webhooks/event-installation-deleted.json')) }
  let(:user_id) { test_event_data['installation']['account']['id'] }

  describe '#perform' do
    #describe 'organization installation created' do
    #  let(:installation_id) { test_org_data['installation']['id'] }
    #  let(:org_id) { test_org_data['installation']['account']['id'] }

    #  it 'calls the SynchronizeOrganizationWorker' do
    #    expect(SynchronizeOrganizationWorker).to receive(:perform_async).with(installation_id, org_id)
    #    described_class.new(test_org_data).perform
    #  end
    #end

    describe 'created' do
      event = nil

      before do
        event = described_class.new(test_event_data).perform
      end

      it 'creates the installation event' do
        expect(event.action).to eq 'created'
      end

      it 'creates the installation for the event' do
        installation = PerigrenGithubWebhooks::Installation.find(135043)
        expect(installation.account_type).to eq 'PerigrenGithubWebhooks::GithubUser'
        expect(installation.events).to eq test_event_data['installation']['events']
        expect(installation.app_id).to eq test_event_data['installation']['app_id']
        expect(installation.installer_id).to eq test_event_data['sender']['id']
      end

      it 'creates a GithubUser for the installation' do
        user = PerigrenGithubWebhooks::GithubUser.find(user_id)
        expect(user.login).to eq 'andrewparrish'
      end

      it 'creates a repository for the event' do
        repo = PerigrenGithubWebhooks::Repository.find(121716388)
        expect(repo.name).to eq 'in-the-eleven'
      end
      
      it 'creates the installation repository record' do
        assoc = PerigrenGithubWebhooks::InstallationsRepository.find_by(perigren_installation_id: 135043, perigren_repository_id:  121716388)
        expect(assoc).not_to be_nil
      end

      it 'creates a sender for the event' do
        expect(event.sender_id).to eq user_id
        expect(event.sender_type).to eq 'PerigrenGithubWebhooks::GithubUser'
      end

      it 'creates a github_user_installations record' do
        assoc = PerigrenGithubWebhooks::GithubUsersInstallations.find_by(perigren_github_user_id: user_id, perigren_installation_id: test_event_data['installation']['id'])
        expect(assoc).not_to be_nil
      end
    end

    describe 'deleted' do
      event = nil

      before do
        event = described_class.new(test_delete_data).perform
      end

      it 'creates a delete event' do
        expect(event.action).to eq 'deleted'
      end

      it 'sets the installation as deleted' do
        installation = PerigrenGithubWebhooks::Installation.find(135043)
        expect(installation.deleted).to be_truthy
        expect(installation.deleted_event_id).to eq event.id
      end
    end
  end
end
