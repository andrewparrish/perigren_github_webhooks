require 'rails_helper'

RSpec.describe PerigrenGithubWebhooks::TeamEventService, type: :service do
  let(:test_data) { JSON.parse(File.read('spec/test_data/webhooks/event-team.json')) }

  describe '#perform' do
    event = nil

    before do
      event = described_class.new(test_data).perform
    end

    it 'creates the team event model' do
      expect(event.action).to eq 'added_to_repository'
    end

    it 'creates the repository for the event' do
      repo = PerigrenGithubWebhooks::Repository.find(135493281)
      expect(repo.node_id).to eq test_data['repository']['node_id']
    end

    it 'creates the organization' do
      org = PerigrenGithubWebhooks::Organization.find(38302899)
      expect(org.login).to eq 'Octocoders'
    end

    it 'creates the team' do
      team = PerigrenGithubWebhooks::Team.find(2723476)
      expect(team.name).to eq 'github'
    end

    it 'creates the sender' do
      user = PerigrenGithubWebhooks::GithubUser.find(test_data['sender']['id'])
      expect(user.login).to eq 'Codertocat'
    end
  end
end
