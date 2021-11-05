module PerigrenGithubWebhooks
  class CommitCommentEventService < GithubWebhookService
    prepend CreateEventCheck

    def perform
      super
      create_repository(@data['repository'])
      create_repository_comment(@data['comment'])
      create_event
    end

    def create_event
      CommitCommentEvent.create(action: @data['action'], sender: @sender,
                                perigren_repository_id: @repo.id, perigren_repository_comment_id: @repo_comment.id)
    end

    def create_repository_comment(comment_data)
      user = create_user(comment_data['user'])
      @repo_comment = RepositoryComment.find_or_create_by(clean_data(comment_data, RepositoryComment, ['user'])) do |c|
        c.owner = user
      end
    end

    private

    def commit_comment_event_data

    end
  end
end
