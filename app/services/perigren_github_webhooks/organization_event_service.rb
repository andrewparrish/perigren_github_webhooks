module PerigrenGithubWebhooks
  class OrganizationEventService < GithubWebhookService
    def perform
      super
      membership_creation
      organization_creation
      event = event_creation
      association_creation
      # TODO: async processes
      #SynchronizeOrganizationWorker.perform_async(@data['installation']['id'],
      #                                           @organization.id)

      event
    end

    def event_creation
      OrganizationEvent.create(
        sender: @sender,
        perigren_organization_id: @organization.id,
        perigren_membership_id: @membership.id,
        action: @data['action']
      )
    end

    def association_creation
      memberships = MembershipsOrganization.find_or_create_by(perigren_membership_id: @membership.id, perigren_organization_id: @organization.id)

      if @data['action'] == 'member_removed'
        memberships.delete_all
        []
      else
        memberships
      end
    end

    def membership_creation
      @user = create_user(@data['membership']['user'])
      @membership = Membership.find_or_create_by(
        state: @data['membership']['state'],
        role: @data['membership']['role'],
        perigren_github_user_id: @user.id
      )
    end
  end
end
