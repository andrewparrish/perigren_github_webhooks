module PerigrenGithubWebhooks
  class GithubWebhooksController < ApplicationController
    include Auth

    class NoServiceFoundError < StandardError; end

    before_action :check_authorization

    def create
      event = request.env['HTTP_X_GITHUB_EVENT']
      PerigrenGithubWebhooks.logger.info "Processing Event Type: #{event}"
      raise(NoServiceFoundError, "no service for event: #{event}") unless service_klass(event)
      service_klass(event).new(JSON.parse(request.body.read)).perform
      head :ok
    end

    private

    def service_klass(event)
      {
        'create' => PerigrenGithubWebhooks::CreateEventService,
        'commit_comment' => PerigrenGithubWebhooks::CommitCommentEventService,
        'integration_installation_repositories' => PerigrenGithubWebhooks::InstallationEventService,
        'integration_installation' => PerigrenGithubWebhooks::InstallationEventService,
        'installation' => PerigrenGithubWebhooks::InstallationEventService,
        'installation_repositories' => PerigrenGithubWebhooks::InstallationRepositoryEventService,
        'member' => PerigrenGithubWebhooks::MemberEventService,
        'membership' => PerigrenGithubWebhooks::MembershipEventService,
        'organization' => PerigrenGithubWebhooks::OrganizationEventService,
        'ping' => PerigrenGithubWebhooks::PingEventService,
        'pull_request' => PerigrenGithubWebhooks::PullRequestEventService,
        'pull_request_review' => PerigrenGithubWebhooks::PullRequestReviewEventService,
        'pull_request_review_comment' => PerigrenGithubWebhooks::PullRequestReviewCommentEventService,
        'push' => PerigrenGithubWebhooks::PushEventService,
        'repository' => PerigrenGithubWebhooks::RepositoryEventService,
        'status' => PerigrenGithubWebhooks::StatusEventService,
        'team' => PerigrenGithubWebhooks::TeamEventService,
        'team_add' => PerigrenGithubWebhooks::TeamAddEventService
      }[event]
    end
  end
end
