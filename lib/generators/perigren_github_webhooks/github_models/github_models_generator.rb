class GithubModelsGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  include Rails::Generators::Migration

  def copy_migrations
    if self.class.migration_exists?('db/migrate', 'perigren_github_webhooks_create_github_models')
      say_status('skipped', "Migration 'perigren_github_webhooks_create_github_models' already exists")
    else
      migration_template(
        'perigren_github_webhooks_create_github_models.rb.erb',
        'db/migrate/perigren_github_webhooks_create_github_models.rb'
      )
    end
  end

  private

  def self.next_migration_number(path)
    Time.now.utc.strftime('%Y%m%d%H%M%S')
  end
end
