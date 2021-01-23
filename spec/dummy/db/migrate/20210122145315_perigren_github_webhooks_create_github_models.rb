class PerigrenGithubWebhooksCreateGithubModels < ActiveRecord::Migration[6.1]
  def change
    create_table(:repositories) do |t|
      t.string :node_id, index: true
      t.string :name
      t.string :full_name
      t.integer :owner_id, index: true
      t.string :owner_type
      t.boolean :private
      t.text :description
      t.string :html_url
      t.boolean :fork
      t.string :homepage
      t.integer :size
      t.boolean :has_issues
      t.boolean :has_projects
      t.boolean :has_downloads
      t.boolean :has_wiki
      t.boolean :has_pages
      t.boolean :archived
      t.integer :open_issues_count
      t.integer :open_issues
      t.string :default_branch
      t.string :language
      t.string :topics, array: true
      t.datetime :pushed_at
      t.json :permissions
      t.boolean :allow_rebase_merge
      t.boolean :allow_squash_merge
      t.boolean :allow_merge_commit
      t.integer :subscribers_count
      t.integer :network_count
      t.json :license
      t.timestamps
    end

    create_table(:create_events) do |t|
      t.integer :repository_id
      t.string :ref, index: true
      t.string :ref_type
      t.string :master_branch
      t.text :description
      t.string :pusher_type
      t.integer :sender_id, index: true
      t.string :sender_type
      t.timestamps
    end

    create_table(:repository_comments) do |t|
      t.string :url
      t.string :html_url
      t.string :node_id, index: true
      t.integer :owner_id, index: true
      t.string :owner_type
      t.integer :position
      t.integer :line
      t.string :path
      t.string :commit_id
      t.string :author_association
      t.text :body
      t.timestamps
    end

    create_table(:commit_comment_events) do |t|
      t.string :action
      t.integer :repository_comment_id
      t.integer :repository_id
      t.integer :sender_id, index: true
      t.string :sender_type
      t.timestamps
    end

    create_table(:installations) do |t|
      t.integer :account_id, index: true
      t.string :account_type
      t.string :repository_selection
      t.integer :app_id, index: true
      t.integer :target_id, index: true
      t.string :target_type
      t.json :permissions
      t.string :events, array: true
      t.string :single_file_name
      t.boolean :deleted, default: false
      t.integer :deleted_event_id
      t.integer :installer_id
      t.timestamps
    end

    create_table(:installation_events) do |t|
      t.string :action
      t.integer :sender_id, index: true
      t.string :sender_type
      t.integer :installation_id
      t.timestamps
    end

    create_table(:marketplace_purchase_events) do |t|
      t.string :action
      t.datetime :effective_date
      t.integer :sender_id, index: true
      t.string :sender_type
      t.integer :marketplace_purchase_id
      t.timestamps
    end

    create_table(:marketplace_purchases) do |t|
      t.integer :account_id, index: true
      t.string :account_type
      t.string :billing_cycle
      t.integer :unit_count
      t.boolean :on_free_trial
      t.datetime :free_trial_ends_on
      t.datetime :next_billing_date
      t.integer :plan_id
      t.timestamps
    end

    create_table(:organizations) do |t|
      t.string :login
      t.string :node_id, index: true
      t.string :avatar_url
      t.text :description
    end

    create_table(:teams) do |t|
      t.integer :organization_id
      t.string :login
      t.string :node_id, index: true
      t.string :avatar_url
      t.boolean :site_admin
      t.string :type
      t.string :organization_billing_email
      t.string :name
      t.string :slug
      t.string :description
      t.string :privacy
      t.string :permission
      t.timestamps
    end

    create_table(:member_events) do |t|
      t.integer :repository_id
      t.string :action
      t.integer :member_id, index: true
      t.string :member_type
      t.json :changes
      t.integer :sender_id, index: true
      t.string :sender_type
      t.timestamps
    end

    create_table(:membership_events) do |t|
      t.integer :organization_id
      t.integer :team_id
      t.string :action
      t.string :scope
      t.string :member_id, index: true
      t.string :member_type
      t.integer :sender_id, index: true
      t.string :sender_type
      t.timestamps
    end

    create_table(:organization_events) do |t|
      t.integer :organization_id
      t.integer :membership_id
      t.string :action
      t.integer :member_id, index: true
      t.string :member_type
      t.integer :sender_id, index: true
      t.string :sender_type
      t.integer :invitation_id, index: true
      t.timestamps
    end

    create_table(:memberships) do |t|
      t.string :state
      t.string :role
      t.timestamps
    end

    create_table(:reviews) do |t|
      t.integer :commit_id
      t.integer :github_user_id
      t.string :node_id
      t.text :body
      t.datetime :submitted_at
      t.string :state
      t.string :html_url
      t.string :pull_request_url
      t.string :author_association
      t.json :_links
      t.timestamps
    end

    create_table(:pull_request_review_events) do |t|
      t.integer :repository_id
      t.integer :pull_request_id
      t.integer :review_id
      t.string :action
      t.integer :sender_id, index: true
      t.string :sender_type
      t.timestamps
    end

    create_table(:milestones) do |t|
      t.string :node_id, index: true
      t.string :title
      t.string :description
      t.string :url
      t.string :html_url
      t.string :labels_url
      t.integer :number
      t.string :state
      t.integer :creator_id, index: true
      t.integer :open_issues
      t.integer :closed_issues
      t.datetime :closed_at
      t.datetime :due_on
      t.timestamps
    end

    create_table(:pull_requests) do |t|
      t.string :node_id, index: true
      t.integer :number
      t.string :state
      t.string :title
      t.text :body
      t.boolean :locked
      t.string :active_lock_reason
      t.datetime :closed_at
      t.datetime :merged_at
      t.json :head
      t.json :base
      t.string :url
      t.string :html_url
      t.string :diff_url
      t.string :patch_url
      t.string :issue_url
      t.string :merge_commit_sha
      t.integer :assignee_id, index: true
      t.integer :creator_id, index: true
      t.string :creator_type
      t.integer :requested_reviewers, array: true
      t.integer :requested_teams, array: true
      t.json :_links
      t.string :author_association
      t.timestamps
    end

    create_table(:review_comments) do |t|
      t.string :url
      t.string :node_id, index: true
      t.text :diff_hunk
      t.string :path
      t.integer :position
      t.integer :original_position
      t.integer :commit_id, index: true
      t.integer :original_commit_id, index: true
      t.integer :in_reply_to_id, index: true
      t.text :body
      t.string :html_url
      t.string :pull_request_url
      t.json :_links
      t.integer :pull_request_id
      t.integer :github_user_id
      t.timestamps
    end

    create_table(:labels) do |t|
      t.string :node_id, index: true
      t.string :name
      t.string :description
      t.string :color
      t.boolean :default
      t.integer :pull_request_id
      t.timestamps
    end

    create_table(:push_events) do |t|
      t.string :ref
      t.string :before
      t.string :after
      t.boolean :created
      t.boolean :deleted
      t.boolean :forced
      t.string :base_ref
      t.string :compare
      t.string :head_commit
      t.integer :pusher_id, index: true
      t.string :pusher_type
      t.integer :sender_id, index: true
      t.string :sender_type
      t.integer :size
      t.integer :distinct_size
      t.integer :repository_id
      t.timestamps
    end

    create_table(:repository_events) do |t|
      t.integer :repository_id
      t.string :action
      t.integer :sender_id, index: true
      t.string :sender_type
      t.timestamps
    end

    create_table(:branches) do |t|
      t.string :name
      t.string :commit_sha, index: true
    end

    create_table(:status_events) do |t|
      t.integer :repository_id
      t.integer :commit_id
      t.string :sha
      t.string :name
      t.string :target_url
      t.string :context
      t.text :description
      t.string :state
      t.integer :sender_id, index: true
      t.string :sender_type
      t.timestamps
    end

    create_table(:team_events) do |t|
      t.integer :organization_id
      t.integer :repository_id
      t.integer :team_id
      t.string :action
      t.integer :sender_id, index: true
      t.string :sender_type
      t.json :changes
      t.timestamps
    end

    create_table(:team_add_events) do |t|
      t.integer :repository_id
      t.integer :organization_id
      t.integer :team_id
      t.integer :sender_id, index: true
      t.string :sender_type
      t.timestamps
    end

    create_table(:github_users) do |t|
      t.string :login
      t.string :node_id, index: true
      t.string :avatar_url
      t.boolean :site_admin
      t.string :type
      t.string :organization_billing_email
      t.string :name
      t.string :company
      t.string :blog
      t.string :location
      t.string :email
      t.boolean :hireable
      t.string :bio
      t.timestamps
    end

    create_table(:plans) do |t|
      t.string :name
      t.string :description
      t.integer :monthly_price_in_cents
      t.integer :yearly_price_in_cents
      t.string :price_model
      t.boolean :has_free_trial
      t.string :unit_name
      t.string :bullets, array: true
      t.timestamps
    end

    create_table(:installation_repositories_events) do |t|
      t.integer :installation_id
      t.string :action
      t.integer :repositories_added, array: true
      t.integer :repositories_removed, array: true
      t.integer :account_id, index: true
      t.string :account_type
      t.integer :sender_id, index: true
      t.string :sender_type
      t.string :repository_selection
      t.integer :app_id, index: true
      t.integer :target_id, index: true
      t.string :target_type
      t.json :permissions
      t.string :events, array: true
      t.string :single_file_name
      t.timestamps
    end

    create_table(:commits) do |t|
      t.string :url
      t.string :sha
      t.string :node_id, index: true
      t.json :commit
      t.integer :author_id, index: true
      t.string :author_type
      t.integer :committer_id, index: true
      t.string :committer_type
      t.string :parents, array: true
    end

    add_foreign_key :create_events, :repositories
    add_foreign_key :commit_comment_events, :repository_comments
    add_foreign_key :commit_comment_events, :repositories
    add_foreign_key :installation_events, :installations
    add_foreign_key :installation_repositories_events, :installations
    add_foreign_key :marketplace_purchase_events, :marketplace_purchases
    add_foreign_key :marketplace_purchases, :plans
    add_foreign_key :teams, :organizations
    add_foreign_key :member_events, :repositories
    add_foreign_key :membership_events, :organizations
    add_foreign_key :membership_events, :teams
    add_foreign_key :organization_events, :organizations
    add_foreign_key :organization_events, :memberships
    add_foreign_key :reviews, :github_users
    add_foreign_key :reviews, :commits
    add_foreign_key :pull_request_review_events, :reviews
    add_foreign_key :pull_request_review_events, :pull_requests
    add_foreign_key :pull_request_review_events, :repositories
    add_foreign_key :pull_requests, :github_users, column: :assignee_id
    add_foreign_key :review_comments, :pull_requests
    add_foreign_key :review_comments, :github_users
    add_foreign_key :labels, :pull_requests
    add_foreign_key :push_events, :repositories
    add_foreign_key :repository_events, :repositories
    add_foreign_key :status_events, :commits
    add_foreign_key :status_events, :repositories
    add_foreign_key :team_events, :teams
    add_foreign_key :team_events, :repositories
    add_foreign_key :team_events, :organizations
    add_foreign_key :team_add_events, :teams
    add_foreign_key :team_add_events, :repositories
    add_foreign_key :team_add_events, :organizations

    create_join_table :installations, :repositories
    create_join_table :installation_events, :repositories
    create_join_table :memberships, :organizations
    create_join_table :memberships, :github_users
    create_join_table :commits, :push_events
    create_join_table :branches, :status_events
    create_join_table :repositories, :github_users
    create_join_table :milestones, :pull_requests
  end
end
