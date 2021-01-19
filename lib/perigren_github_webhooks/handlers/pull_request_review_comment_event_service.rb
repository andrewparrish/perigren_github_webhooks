module PerigrenGithubWebhooks
  class PullRequestReviewCommentEventService < GithubWebhookService
    def perform
      super
      @user = create_user(@data['comment']['user'])
      create_repository(@data['repository'])
      create_pull_request(@data['pull_request'])  
      create_review_comment(@data['comment'])

      event = PullRequestReviewCommentEvent.create(
        action: @data['action'],
        sender: @sender,
        repository_id: @repo.id,
        pull_request_id: @pr.id,
        review_comment_id: @comment.id
      )

      FeedbackLeftNotificationWorker.perform_async(@pr.id, @sender.id)
      SlackWorkers::FeedbackLeftSlackWorker.perform_async(@pr.id, @sender.id)
      event
    end

    def create_review_comment(comment_data)
      comment_data['github_user_id'] = @user.id
      comment_data['pull_request_id'] = @pr.id
      @comment = ReviewComment.find_or_create_by(
        clean_data(comment_data, ReviewComment, ['_links'])
      ) 
    end
  end
end
