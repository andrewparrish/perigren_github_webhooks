module PerigrenGithubWebhooks
  # TODO: Relationships between repos, orgs, teams
  class TeamEventService < GithubWebhookService
    prepend CreateEventCheck

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
        perigren_repository_id: @repo.id,
        action: @data['action'],
        perigren_team_id: @team.id,
        event_changes: @data['changes'],
        perigren_organization_id: @organization.id
      )
    end
  end
end
