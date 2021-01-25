require 'rails_helper'

RSpec.describe PerigrenGithubWebhooks::TeamAddEventService, type: :service do
  let(:test_data) { JSON.parse(File.read('spec/test_data/webhooks/event-team-add.json')) }

  describe '#perform' do
    event = nil

    before do
      event = described_class.new(test_data).perform
    end

    it 'creates the team add event model' do
      expect(event.team_id).to eq test_data['team']['id']
      expect(event.sender_id).to eq test_data['sender']['id']
      expect(event.sender_type).to eq 'PerigrenGithubWebhooks::Organization'
    end

    it 'creates the repo' do
      repo = PerigrenGithubWebhooks::Repository.find(test_data['repository']['id'])
      expect(repo.node_id).to eq test_data['repository']['node_id']
    end

    it 'creates the org' do
      org = PerigrenGithubWebhooks::Organization.find(test_data['organization']['id'])
      expect(org.login).to eq 'Octocoders'
    end

    it 'creates the team' do
      team = PerigrenGithubWebhooks::Team.find(test_data['team']['id'])
      expect(team.name).to eq 'github'
      expect(team.organization_id).to eq test_data['team']['organization_id']
    end
  end
end
