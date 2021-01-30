module PerigrenGithubWebhooks
  module AfterExecutable
    def perform
      results = super
      self.send(:after_event, *args, &cb) if self.respond_to?(:after_event)
      results
    end
  end
end
