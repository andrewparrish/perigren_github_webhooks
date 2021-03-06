module PerigrenGithubWebhooks
  class AfterEventGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    class_option :event, type: :string

    EVENT_CLASSES = {
      'installation_repository' => 'InstallationRepository',
      'ping' => 'Ping'
    }

    def create_override_file
      @event_class = EVENT_CLASSES[options[:event]]
      template "after_event.rb.erb", "app/overrides/perigren_github_webhooks/#{options[:event]}_event_service_override.rb"
    end
  end
end
