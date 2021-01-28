module PerigrenGithubWebhooks
  class GithubWebhooksController < ApplicationController
    class NoServiceFoundError < StandardError; end

    before_action :check_authorization

    def create
      event = request.env['HTTP_X_GITHUB_EVENT']
      raise(NoServiceFoundError, "no service for event: #{event}") unless service_klass(event)
      service_klass(event).new(JSON.parse(request.body.read)).perform
      render text: "Successfully completed event processing for event: #{event}"
    end

    private

    def check_authorization
      # TODO: This should be configurable if you want to include auth
      signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'),
                                                    ENV['GITHUB_SECRET'], request.body.read)
      render text: "Signatures didn't match!", status: 503 unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
    end

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
