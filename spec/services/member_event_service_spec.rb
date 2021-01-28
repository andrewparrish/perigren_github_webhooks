require 'rails_helper'

RSpec.describe PerigrenGithubWebhooks::MemberEventService, type: :service do
  let(:test_data) { JSON.parse(File.read('spec/test_data/webhooks/event-member.json')) }

  describe '#perform' do
    event = nil

    before do
      event = described_class.new(test_data).perform
    end

    it 'creates the member event' do
      expect(event.event_changes).to eq test_data['changes']
      expect(event.perigren_repository_id).to eq test_data['repository']['id']
      expect(event.member_id).to eq test_data['member']['id']
      expect(event.sender_id).to eq 21031067
    end

    it 'creates the member' do
      user = PerigrenGithubWebhooks::GithubUser.find(583231)
      expect(user.login).to eq 'octocat'
      expect(user.node_id).to eq test_data['member']['node_id']
    end

    it 'creates the repository' do
      repo = PerigrenGithubWebhooks::Repository.find(135493233)
      expect(repo.node_id).to eq test_data['repository']['node_id']
      expect(repo.owner_id).to eq test_data['repository']['owner']['id']
    end

    it 'creates the sender' do
      user = PerigrenGithubWebhooks::GithubUser.find(21031067)
      expect(user.login).to eq 'Codertocat'
    end
  end
end
