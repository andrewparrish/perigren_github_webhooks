module PerigrenGithubWebhooks
  class MemberEventService < GithubWebhookService
    prepend CreateEventCheck

    def perform
      super

      @member = create_user(@data['member'])
      create_repository(@data['repository'])

      create_event
    end

    def create_event
      MemberEvent.create(
        sender: @sender,
        action: @data['action'],
        member: @member,
        event_changes: @data['changes'],
        perigren_repository_id: @repo.id
      )
    end
  end
end
