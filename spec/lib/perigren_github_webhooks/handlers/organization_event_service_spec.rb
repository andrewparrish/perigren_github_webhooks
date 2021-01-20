require 'perigren_github_webhooks'

RSpec.describe PerigrenGithubWebhooks::Handlers::OrganizationEventService, type: :service do
  let(:test_data) { JSON.parse(File.read('spec/test_data/webhooks/event-organization.json')) }

  describe '#perform' do
    event = nil

    before do
      event = described_class.new(test_data).perform
    end

    it 'creates the organization event' do
      expect(event.action).to eq 'member_added'
      expect(event.organization_id).to eq test_data['organization']['id']
    end

    it 'calls the background job' do
      expect(SynchronizeOrganizationWorker).to receive(:perform_async).with(
        test_data['installation']['id'], test_data['organization']['id']
      )
      described_class.new(test_data).perform
    end

    it 'creates the membership' do
      membership = Membership.find_by(github_user_id: test_data['membership']['user']['id'])
      expect(membership.role).to eq 'member'
    end

    it 'creates the organization' do
      organization = Organization.find(test_data['organization']['id'])
      expect(organization.login).to eq 'Octocoders'
      expect(organization.node_id).to eq test_data['organization']['node_id']
    end

    it 'creates the  sender' do
      sender = GithubUser.find(test_data['sender']['id'])
      expect(sender.login).to eq 'Codertocat'
      expect(sender.node_id).to eq test_data['sender']['node_id']
    end

    it 'creates the membership organizations record' do
      assoc = MembershipsOrganization.find_by(organization_id: test_data['organization']['id'])
      expect(assoc).not_to be_nil
    end
  end
end
