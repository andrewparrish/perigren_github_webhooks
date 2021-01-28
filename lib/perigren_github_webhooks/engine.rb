require 'rails'

module PerigrenGithubWebhooks
  def self.table_name_prefix
    'perigren_'
  end

  class Engine < ::Rails::Engine
    isolate_namespace PerigrenGithubWebhooks
  end
end
