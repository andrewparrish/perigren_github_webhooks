module PerigrenGithubWebhooks
  class RepositoryEventService < GithubWebhookService
    def perform
      super
      create_repository(@data['repository'])
      RepositoryEvent.create(
        action: @data['action'],
        sender: @sender,
        perigren_installation_id: @data['installation']['id']
      )
    end
  end
end
