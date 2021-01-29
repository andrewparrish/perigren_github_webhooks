module PerigrenGithubWebhooks
  class InitializersGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    def create_initializer_file
      copy_file "perigren_github_webhooks.rb", "config/initializers/perigren_github_webhooks.rb"
    end
  end
end
