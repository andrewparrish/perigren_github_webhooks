require 'rails_helper'

RSpec.describe PerigrenGithubWebhooks::MembershipEventService, type: :service do
  let(:test_data) { JSON.parse(File.read('spec/test_data/webhooks/event-membership.json')) }

  describe '#perform' do
    event = nil
    
    before do
      event = described_class.new(test_data).perform
    end

    it 'creates the membership event' do
      expect(event.scope).to eq 'team'
      expect(event.member_id).to eq '21031067'
      expect(event.member_type).to eq 'PerigrenGithubWebhooks::GithubUser'
      expect(event.sender_id).to eq 21031067
      expect(event.team_id).to eq 2723476
      expect(event.organization_id).to eq 38302899
    end

    it 'creates the member user model' do
      user = PerigrenGithubWebhooks::GithubUser.find(21031067)
      expect(user.login).to eq 'Codertocat'
      expect(user.node_id).to eq test_data['member']['node_id']
    end

    it 'creates the team model' do
      team = PerigrenGithubWebhooks::Team.find(2723476)
      expect(team.name).to eq 'github'
      expect(team.node_id).to eq test_data['team']['node_id']
    end

    it 'crates the organization model' do
      organization = PerigrenGithubWebhooks::Organization.find(38302899)
      expect(organization.login).to eq 'Octocoders'
      expect(organization.node_id).to eq test_data['organization']['node_id']
    end
  end
end
