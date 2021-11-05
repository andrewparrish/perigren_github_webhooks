module PerigrenGithubWebhooks
  class PushEventService < GithubWebhookService
    prepend CreateEventCheck

    def perform
      super
      create_repository(@data['repository'])
      create_event
    end

    def create_event
      PushEvent.create(
        clean_data(@data, PushEvent, ['commits']).merge(
          sender: @sender,
          perigren_repository_id: @repo.id,
          commits: @data['commits'].map { |c| c['sha'] }
        )
      )
    end
  end
end
