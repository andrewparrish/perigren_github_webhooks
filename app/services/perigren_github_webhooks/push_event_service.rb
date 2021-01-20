module PerigrenGithubWebhooks
  module Handlers
    class PushEventService < GithubWebhookService
      def perform
        super
        create_repository(@data['repository'])

        PushEvent.create(
          clean_data(@data, PushEvent, ['commits']).merge(
            sender: @sender,
            repository_id: @repo.id,
            commits: @data['commits'].map { |c| c['sha'] }
          )
        )
      end
    end
  end
end
