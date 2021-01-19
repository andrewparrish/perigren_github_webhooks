module GithubWebhookServices
  class StatusEventService < GithubWebhookService
    def perform
      super
      create_repository(@data['repository'])
      create_commit(@data['commit'])
      create_event
    end

    def create_event
      event = StatusEvent.create(
        sha: @data['sha'],
        name: @data['name'],
        state: @data['state'],
        target_url: @data['target_url'],
        context: @data['context'],
        description: @data['description'],
        commit_id: @commit.id,
        sender: @sender
      )
      event.update(id: @data['id'])
      event
    end
  end
end
