module PerigrenGithubWebhooks
  class PingEventService < GithubWebhookService
    def initialize(data)
    end

    def perform
      true
    end
  end
end
