module PerigrenGithubWebhooks
  class PushEventService < GithubWebhookService
    def perform
      super
      create_repository(@data['repository'])

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
