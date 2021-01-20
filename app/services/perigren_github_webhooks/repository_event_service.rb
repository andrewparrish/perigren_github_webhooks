module PerigrenGithubWebhooks
  module Handlers
    class RepositoryEventService < GithubWebhookService
      def perform
        super
        create_repository(@data['repository'])
        RepositoryEvent.create(
          action: @data['action'],
          sender: @sender,
          installation_id: @data['installation']['id']
        )
      end
    end
  end
end
