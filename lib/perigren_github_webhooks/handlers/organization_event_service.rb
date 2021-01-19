module GithubWebhookServices
  class OrganizationEventService < GithubWebhookService
    def perform
      super
      membership_creation
      organization_creation
      event = event_creation
      association_creation
      SynchronizeOrganizationWorker.perform_async(@data['installation']['id'],
                                                  @organization.id)

      event
    end

    def event_creation
      OrganizationEvent.create(
        sender: @sender,
        organization_id: @organization.id,
        membership_id: @membership.id,
        action: @data['action']
      )
    end

    def association_creation
      memberships = MembershipsOrganization.find_or_create_by(membership_id: @membership.id, organization_id: @organization.id)

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
        github_user_id: @user.id
      )
    end

    private

    def membership_data(data)
      return {
        state: data['state'],
        role: data['role'],
        github_user_id: data['user']['id']
      }
    end
  end
end
