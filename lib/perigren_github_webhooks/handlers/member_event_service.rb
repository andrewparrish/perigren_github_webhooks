module PerigrenGithubWebhooks
  class MemberEventService < GithubWebhookService
    def perform
      super

      @member = create_user(@data['member'])
      create_repository(@data['repository'])

      MemberEvent.create(
        sender: @sender,
        action: @data['action'],
        member: @member,
        event_changes: @data['changes'],
        repository_id: @repo.id
      )
    end
  end
end
