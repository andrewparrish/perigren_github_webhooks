PerigrenGithubWebhooks.setup do |config|
  # https://docs.github.com/en/developers/webhooks-and-events/securing-your-webhooks
  config.use_webhooks_secret_auth = false
end
