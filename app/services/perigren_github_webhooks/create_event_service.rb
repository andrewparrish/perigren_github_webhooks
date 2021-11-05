module PerigrenGithubWebhooks
  class CreateEventService < GithubWebhookService
    prepend CreateEventCheck

    def perform
      super
      create_repository(@data['repository'])
      create_event
    end

    def create_event
      CreateEvent.create(clean_data(@data, CreateEvent)) do |event|
        event.sender = @sender
        event.perigren_repository_id = @repo.id
      end
    end
  end
end
