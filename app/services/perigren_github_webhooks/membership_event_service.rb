module PerigrenGithubWebhooks
  class MembershipEventService < GithubWebhookService
    def perform
      super
      member_creation
      organization_creation
      team_creation
      event_creation
    end

    def event_creation
      MembershipEvent.create(
        sender: @sender,
        action: @data['action'],
        scope: @data['scope'],
        member: @member,
        perigren_team_id: @team.id,
        perigren_organization_id: @organization.id
      )
    end

    def member_creation
      @member = create_user(@data['member'])
    end

    def team_creation
      @team = Team.find_or_create_by clean_data(@data['team'], Team, ["type"])
    end
  end
end
