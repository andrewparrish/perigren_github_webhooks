require "perigren_github_webhooks/version"
require "perigren_github_webhooks/engine"
require "perigren_github_webhooks/auth"
require "perigren_github_webhooks/after_executable"

module PerigrenGithubWebhooks
  # TODO: Add config for this
  mattr_accessor :user_class,
                 :use_webhooks_secret_auth

  self.use_webhooks_secret_auth = true
  self.user_class = nil

  def self.setup(&block)
    yield self
  end

  def self.logger
    @@logger ||= defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
  end

  def self.logger=(logger)
    @@logger = logger
  end
end

