module PerigrenGithubWebhooks
  class TeamAddEventService < GithubWebhookService
    prepend CreateEventCheck

    def perform
      super
      create_repository(@data['repository'])
      organization_creation
      create_team(@data['team'])
      create_event
    end

    def create_event
      TeamAddEvent.create(
        sender: @sender,
        perigren_repository_id: @repo.id,
        perigren_team_id: @team.id,
        perigren_organization_id: @organization.id
      )
    end
  end
end
