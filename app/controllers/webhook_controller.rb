class WebhookController < ApplicationController
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
    signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'),
                                                  ENV['GITHUB_SECRET'], request.body.read)
    render text: "Signatures didn't match!", status: 503 unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
  end

  def service_klass(event)
    {
      'create' => GithubWebhookServices::CreateEventService,
      'commit_comment' => GithubWebhookServices::CommitCommentEventService,
      'integration_installation_repositories' => GithubWebhookServices::InstallationEventService,
      'integration_installation' => GithubWebhookServices::InstallationEventService,
      'installation' => GithubWebhookServices::InstallationEventService,
      'installation_repositories' => GithubWebhookServices::InstallationRepositoryEventService,
      'member' => GithubWebhookServices::MemberEventService,
      'membership' => GithubWebhookServices::MembershipEventService,
      'organization' => GithubWebhookServices::OrganizationEventService,
      'ping' => GithubWebhookServices::PingEventService,
      'pull_request' => GithubWebhookServices::PullRequestEventService,
      'pull_request_review' => GithubWebhookServices::PullRequestReviewEventService,
      'pull_request_review_comment' => GithubWebhookServices::PullRequestReviewCommentEventService,
      'push' => GithubWebhookServices::PushEventService,
      'repository' => GithubWebhookServices::RepositoryEventService,
      'status' => GithubWebhookServices::StatusEventService,
      'team' => GithubWebhookServices::TeamEventService,
      'team_add' => GithubWebhookServices::TeamAddEventService
    }[event]
  end
end
