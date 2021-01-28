require 'perigren_github_webhooks'

RSpec.describe PerigrenGithubWebhooks::OrganizationEventService, type: :service do
  let(:test_data) { JSON.parse(File.read('spec/test_data/webhooks/event-organization.json')) }

  describe '#perform' do
    event = nil

    before do
      event = described_class.new(test_data).perform
    end

    it 'creates the organization event' do
      expect(event.action).to eq 'member_added'
      expect(event.perigren_organization_id).to eq test_data['organization']['id']
    end

    #it 'calls the background job' do
    #  expect(SynchronizeOrganizationWorker).to receive(:perform_async).with(
    #    test_data['installation']['id'], test_data['organization']['id']
    #  )
    #  described_class.new(test_data).perform
    #end

    it 'creates the membership' do
      membership = PerigrenGithubWebhooks::Membership.find_by(perigren_github_user_id: test_data['membership']['user']['id'])
      expect(membership.role).to eq 'member'
    end

    it 'creates the organization' do
      organization = PerigrenGithubWebhooks::Organization.find(test_data['organization']['id'])
      expect(organization.login).to eq 'Octocoders'
      expect(organization.node_id).to eq test_data['organization']['node_id']
    end

    it 'creates the  sender' do
      sender = PerigrenGithubWebhooks::GithubUser.find(test_data['sender']['id'])
      expect(sender.login).to eq 'Codertocat'
      expect(sender.node_id).to eq test_data['sender']['node_id']
    end

    it 'creates the membership organizations record' do
      assoc = PerigrenGithubWebhooks::MembershipsOrganization.find_by(perigren_organization_id: test_data['organization']['id'])
      expect(assoc).not_to be_nil
    end
  end
end
