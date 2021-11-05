module PerigrenGithubWebhooks
  class RepositoryEventService < GithubWebhookService
    prepend CreateEventCheck

    def perform
      super
      create_repository(@data['repository'])
      create_event
    end

    def create_event
      RepositoryEvent.create(
        action: @data['action'],
        sender: @sender,
        perigren_installation_id: @data['installation']['id']
      )
    end
  end
end
