module GithubWebhookServices
  # TODO: Relationships between repos, orgs, teams
  class TeamEventService < GithubWebhookService
    def perform
      super
      create_repository(@data['repository'])
      organization_creation
      create_team(@data['team'])
      create_event
    end

    def create_event
      TeamEvent.create(
        sender: @sender,
        repository_id: @repo.id,
        action: @data['action'],
        team_id: @team.id,
        event_changes: @data['changes'],
        organization_id: @organization.id
      )
    end
  end
end
