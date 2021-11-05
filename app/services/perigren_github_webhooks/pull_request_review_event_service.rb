module PerigrenGithubWebhooks
  class PullRequestReviewEventService < GithubWebhookService
    prepend CreateEventCheck

    def perform
      super
      @user = create_user(@data['review']['user'])
      create_repository(@data['repository'])
      create_pull_request(@data['pull_request'])
      create_review(@data['review'])
      create_event      
    end

    def create_event
      PullRequestReviewEvent.create(
        action: @data['action'],
        perigren_installation_id: @data['installation']['id'],
        sender: @sender,
        perigren_repository_id: @repo.id,
        perigren_pull_request_id: @pr.id,
        perigren_review_id: @review.id
      )
    end

    def create_review(review_data)
      review_data['github_user_id'] = @user.id 
      review_data['perigren_pull_request_id'] = @pr.id
      @review = Review.find_or_create_by(
        clean_data(review_data, Review, ['_links'])
      )
    end
  end
end
