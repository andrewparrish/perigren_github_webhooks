module PerigrenGithubWebhooks
  class TeamAddEventService < GithubWebhookService
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
        repository_id: @repo.id,
        team_id: @team.id,
        organization_id: @organization.id
      )
    end
  end
end
