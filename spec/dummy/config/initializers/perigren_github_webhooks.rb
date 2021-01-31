PerigrenGithubWebhooks.setup do |config|
  # https://docs.github.com/en/developers/webhooks-and-events/securing-your-webhooks
  config.use_webhooks_secret_auth = false

  overrides = "#{Rails.root}/app/overrides"
  Rails.autoloaders.main.ignore(overrides)
  Rails.application.config.to_prepare do
    Dir.glob("#{overrides}/**/*_override.rb").each do |override|
      load override
    end
  end
end
