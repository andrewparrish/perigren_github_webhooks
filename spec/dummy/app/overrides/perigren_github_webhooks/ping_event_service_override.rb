PerigrenGithubWebhooks::PingEventService.class_eval do
  prepend PerigrenGithubWebhooks::AfterExecutable

  def after_event
    puts "FOOOOOOOOOOO"
  end
end
