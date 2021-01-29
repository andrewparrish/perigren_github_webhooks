require 'rails'

module PerigrenGithubWebhooks
  def self.table_name_prefix
    'perigren_'
  end

  class Engine < ::Rails::Engine
    isolate_namespace PerigrenGithubWebhooks

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
