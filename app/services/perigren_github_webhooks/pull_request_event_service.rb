module PerigrenGithubWebhooks
  class PullRequestEventService < GithubWebhookService
    prepend CreateEventCheck

    def perform
      super
      create_repository(@data['repository'])
      create_pull_request(@data['pull_request'])
      event = create_event

      # TODO: async processes
      #SynchronizePullRequestWorker.perform_async(@data['installation']['id'],  @pr.id)
      #StalePullRequestWorker.perform_async(@data['installation']['id'], @pr.id)
      event
    end

    def create_event
      PullRequestEvent.create(
        action: @data['action'],
        sender: @sender,
        perigren_repository_id: @repo.id,
        perigren_pull_request_id: @pr.id,
        perigren_installation_id: @data['installation']['id'],
        number: @data['number']
      )
    end

    def create_creator
      @creator = create_user(@data['pull_request']['user'])
    end

    def pull_request_data
      {
        requested_reviewers: @data['pull_request']['requested_reviewers'].map { |r| r['id'] },
        requested_teams: @data['pull_request']['requested_teams'].map { |r| r['id'] },
        creator: @creator
      }
    end
  end
end
