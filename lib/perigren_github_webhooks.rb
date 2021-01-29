require "perigren_github_webhooks/version"
require "perigren_github_webhooks/engine"
require "perigren_github_webhooks/auth"

module PerigrenGithubWebhooks
  # TODO: Add config for this
  mattr_accessor :user_class

  mattr_accessor :use_webhooks_secret_auth
  @@use_webhooks_secret_auth = true
end

