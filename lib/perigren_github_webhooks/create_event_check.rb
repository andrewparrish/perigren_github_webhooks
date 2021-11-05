module PerigrenGithubWebhooks
  module CreateEventCheck
    def create_event
      return if not PerigrenGithubWebhooks.save_events_to_db
      super
    end
  end
end
