module PerigrenGithubWebhooks
  class PullRequestReviewCommentEventService < GithubWebhookService
    prepend CreateEventCheck

    def perform
      super
      @user = create_user(@data['comment']['user'])
      create_repository(@data['repository'])
      create_pull_request(@data['pull_request'])  
      create_review_comment(@data['comment'])
      #FeedbackLeftNotificationWorker.perform_async(@pr.id, @sender.id)
      #SlackWorkers::FeedbackLeftSlackWorker.perform_async(@pr.id, @sender.id)
      create_event
    end

    def create_event
      event = PullRequestReviewCommentEvent.create(
        action: @data['action'],
        sender: @sender,
        perigren_repository_id: @repo.id,
        perigren_pull_request_id: @pr.id,
        perigren_review_comment_id: @comment.id
      )
      event
    end

    def create_review_comment(comment_data)
      comment_data['perigren_github_user_id'] = @user.id
      comment_data['perigren_pull_request_id'] = @pr.id
      @comment = ReviewComment.find_or_create_by(
        clean_data(comment_data, ReviewComment, ['_links'])
      ) 
    end
  end
end
