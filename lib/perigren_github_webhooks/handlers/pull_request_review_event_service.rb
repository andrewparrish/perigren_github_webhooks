module PerigrenGithubWebhooks
  class PullRequestReviewEventService < GithubWebhookService
    def perform
      super
      @user = create_user(@data['review']['user'])
      create_repository(@data['repository'])
      create_pull_request(@data['pull_request'])
      create_review(@data['review'])

      PullRequestReviewEvent.create(
        action: @data['action'],
        installation_id: @data['installation']['id'],
        sender: @sender,
        repository_id: @repo.id,
        pull_request_id: @pr.id,
        review_id: @review.id
      )
    end

    def create_review(review_data)
      review_data['github_user_id'] = @user.id 
      review_data['pull_request_id'] = @pr.id
      @review = Review.find_or_create_by(
        clean_data(review_data, Review, ['_links'])
      )
    end
  end
end
