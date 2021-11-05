require 'rails_helper'
require 'perigren_github_webhooks'

RSpec.describe PerigrenGithubWebhooks::GithubWebhookService, type: :service do
  let(:test_data) { JSON.parse(File.read('spec/test_data/webhooks/event-commit-comment.json')) }

  describe '#create_event' do
    describe 'save_events_to_db disabled' do
      before do
        PerigrenGithubWebhooks.save_events_to_db = false
        PerigrenGithubWebhooks::CommitCommentEventService.new(test_data).perform
      end

      it 'does not save the event' do
        event = PerigrenGithubWebhooks::CommitCommentEvent.first
        expect(event).to be_nil
      end
    end
  end

  after do
    PerigrenGithubWebhooks.save_events_to_db = true
  end
end
