# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_25_015916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branches", force: :cascade do |t|
    t.string "name"
    t.string "commit_sha"
    t.index ["commit_sha"], name: "index_branches_on_commit_sha"
  end

  create_table "branches_status_events", id: false, force: :cascade do |t|
    t.bigint "branch_id", null: false
    t.bigint "status_event_id", null: false
  end

  create_table "commit_comment_events", force: :cascade do |t|
    t.string "action"
    t.integer "repository_comment_id"
    t.integer "perigren_repository_id"
    t.integer "sender_id"
    t.string "sender_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sender_id"], name: "index_commit_comment_events_on_sender_id"
  end

  create_table "commits", force: :cascade do |t|
    t.boolean "distinct"
    t.text "message"
    t.string "url"
    t.string "sha"
    t.string "node_id"
    t.json "commit"
    t.integer "author_id"
    t.string "author_type"
    t.integer "committer_id"
    t.string "committer_type"
    t.string "parents", array: true
    t.index ["author_id"], name: "index_commits_on_author_id"
    t.index ["committer_id"], name: "index_commits_on_committer_id"
    t.index ["node_id"], name: "index_commits_on_node_id"
  end

  create_table "commits_push_events", id: false, force: :cascade do |t|
    t.bigint "commit_id", null: false
    t.bigint "push_event_id", null: false
  end

  create_table "create_events", force: :cascade do |t|
    t.integer "perigren_repository_id"
    t.string "ref"
    t.string "ref_type"
    t.string "master_branch"
    t.text "description"
    t.string "pusher_type"
    t.integer "sender_id", null: false
    t.string "sender_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ref"], name: "index_create_events_on_ref"
    t.index ["sender_id"], name: "index_create_events_on_sender_id"
  end

  create_table "installation_events", force: :cascade do |t|
    t.string "action"
    t.integer "sender_id"
    t.string "sender_type"
    t.integer "installation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sender_id"], name: "index_installation_events_on_sender_id"
  end

  create_table "installation_events_perigren_repositories", id: false, force: :cascade do |t|
    t.bigint "installation_event_id", null: false
    t.bigint "perigren_repository_id", null: false
  end

  create_table "installation_perigren_repositories_events", force: :cascade do |t|
    t.integer "installation_id"
    t.string "action"
    t.integer "perigren_repositories_added", array: true
    t.integer "perigren_repositories_removed", array: true
    t.integer "account_id"
    t.string "account_type"
    t.integer "sender_id"
    t.string "sender_type"
    t.string "repository_selection"
    t.integer "app_id"
    t.integer "target_id"
    t.string "target_type"
    t.json "permissions"
    t.string "events", array: true
    t.string "single_file_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_installation_perigren_repositories_events_on_account_id"
    t.index ["app_id"], name: "index_installation_perigren_repositories_events_on_app_id"
    t.index ["sender_id"], name: "index_installation_perigren_repositories_events_on_sender_id"
    t.index ["target_id"], name: "index_installation_perigren_repositories_events_on_target_id"
  end

  create_table "installations", force: :cascade do |t|
    t.integer "account_id"
    t.string "account_type"
    t.string "repository_selection"
    t.integer "app_id"
    t.integer "target_id"
    t.string "target_type"
    t.json "permissions"
    t.string "events", array: true
    t.string "single_file_name"
    t.boolean "deleted", default: false
    t.integer "deleted_event_id"
    t.integer "installer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_installations_on_account_id"
    t.index ["app_id"], name: "index_installations_on_app_id"
    t.index ["target_id"], name: "index_installations_on_target_id"
  end

  create_table "installations_perigren_repositories", id: false, force: :cascade do |t|
    t.bigint "installation_id", null: false
    t.bigint "perigren_repository_id", null: false
  end

  create_table "labels", force: :cascade do |t|
    t.string "node_id"
    t.string "name"
    t.string "description"
    t.string "color"
    t.boolean "default"
    t.integer "pull_request_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["node_id"], name: "index_labels_on_node_id"
  end

  create_table "marketplace_purchase_events", force: :cascade do |t|
    t.string "action"
    t.datetime "effective_date"
    t.integer "sender_id"
    t.string "sender_type"
    t.integer "marketplace_purchase_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sender_id"], name: "index_marketplace_purchase_events_on_sender_id"
  end

  create_table "marketplace_purchases", force: :cascade do |t|
    t.integer "account_id"
    t.string "account_type"
    t.string "billing_cycle"
    t.integer "unit_count"
    t.boolean "on_free_trial"
    t.datetime "free_trial_ends_on"
    t.datetime "next_billing_date"
    t.integer "plan_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_marketplace_purchases_on_account_id"
  end

  create_table "member_events", force: :cascade do |t|
    t.integer "perigren_repository_id"
    t.string "action"
    t.integer "member_id"
    t.string "member_type"
    t.json "event_changes"
    t.integer "sender_id"
    t.string "sender_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_member_events_on_member_id"
    t.index ["sender_id"], name: "index_member_events_on_sender_id"
  end

  create_table "membership_events", force: :cascade do |t|
    t.integer "perigren_organization_id"
    t.integer "team_id"
    t.string "action"
    t.string "scope"
    t.string "member_id"
    t.string "member_type"
    t.integer "sender_id"
    t.string "sender_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_membership_events_on_member_id"
    t.index ["sender_id"], name: "index_membership_events_on_sender_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "perigren_github_user_id"
    t.string "state"
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["perigren_github_user_id"], name: "index_memberships_on_perigren_github_user_id"
  end

  create_table "memberships_perigren_organizations", id: false, force: :cascade do |t|
    t.bigint "membership_id", null: false
    t.bigint "perigren_organization_id", null: false
  end

  create_table "milestones", force: :cascade do |t|
    t.string "node_id"
    t.string "title"
    t.string "description"
    t.string "url"
    t.string "html_url"
    t.string "labels_url"
    t.integer "number"
    t.string "state"
    t.integer "creator_id"
    t.integer "open_issues"
    t.integer "closed_issues"
    t.datetime "closed_at"
    t.datetime "due_on"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_milestones_on_creator_id"
    t.index ["node_id"], name: "index_milestones_on_node_id"
  end

  create_table "milestones_pull_requests", id: false, force: :cascade do |t|
    t.bigint "milestone_id", null: false
    t.bigint "pull_request_id", null: false
  end

  create_table "organization_events", force: :cascade do |t|
    t.integer "perigren_organization_id"
    t.integer "membership_id"
    t.string "action"
    t.integer "member_id"
    t.string "member_type"
    t.integer "sender_id"
    t.string "sender_type"
    t.integer "invitation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invitation_id"], name: "index_organization_events_on_invitation_id"
    t.index ["member_id"], name: "index_organization_events_on_member_id"
    t.index ["sender_id"], name: "index_organization_events_on_sender_id"
  end

  create_table "perigren_github_users", force: :cascade do |t|
    t.string "login"
    t.string "node_id"
    t.string "avatar_url"
    t.boolean "site_admin"
    t.string "type"
    t.string "organization_billing_email"
    t.string "name"
    t.string "company"
    t.string "blog"
    t.string "location"
    t.string "email"
    t.boolean "hireable"
    t.string "bio"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["node_id"], name: "index_perigren_github_users_on_node_id"
  end

  create_table "perigren_github_users_installations", force: :cascade do |t|
    t.bigint "perigren_github_user_id"
    t.bigint "installation_id"
    t.index ["installation_id"], name: "index_perigren_github_users_installs_on_perigren_install_id"
    t.index ["perigren_github_user_id"], name: "index_perigren_github_users_installs_on_perigren_github_user_id"
  end

  create_table "perigren_github_users_perigren_organizations", force: :cascade do |t|
    t.bigint "perigren_github_user_id"
    t.bigint "perigren_organization_id"
    t.index ["perigren_github_user_id"], name: "index_perigren_github_users_orgs_on_perigren_github_user_id"
    t.index ["perigren_organization_id"], name: "index_perigren_github_users_orgs_on_perigren_organization_id"
  end

  create_table "perigren_github_users_repositories", id: false, force: :cascade do |t|
    t.bigint "perigren_repository_id", null: false
    t.bigint "perigren_github_user_id", null: false
  end

  create_table "perigren_organizations", force: :cascade do |t|
    t.string "login"
    t.string "node_id"
    t.string "avatar_url"
    t.text "description"
    t.index ["node_id"], name: "index_perigren_organizations_on_node_id"
  end

  create_table "perigren_repositories", force: :cascade do |t|
    t.string "node_id"
    t.string "name"
    t.string "full_name"
    t.integer "owner_id"
    t.string "owner_type"
    t.boolean "private"
    t.text "description"
    t.string "html_url"
    t.boolean "fork"
    t.string "homepage"
    t.integer "size"
    t.boolean "has_issues"
    t.boolean "has_projects"
    t.boolean "has_downloads"
    t.boolean "has_wiki"
    t.boolean "has_pages"
    t.boolean "archived"
    t.integer "open_issues_count"
    t.integer "open_issues"
    t.string "default_branch"
    t.string "language"
    t.string "topics", array: true
    t.datetime "pushed_at"
    t.json "permissions"
    t.boolean "allow_rebase_merge"
    t.boolean "allow_squash_merge"
    t.boolean "allow_merge_commit"
    t.integer "subscribers_count"
    t.integer "network_count"
    t.json "license"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["node_id"], name: "index_perigren_repositories_on_node_id"
    t.index ["owner_id"], name: "index_perigren_repositories_on_owner_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "monthly_price_in_cents"
    t.integer "yearly_price_in_cents"
    t.string "price_model"
    t.boolean "has_free_trial"
    t.string "unit_name"
    t.string "bullets", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pull_request_events", force: :cascade do |t|
    t.string "action"
    t.integer "number"
    t.integer "pull_request_id"
    t.integer "perigren_repository_id"
    t.integer "sender_id"
    t.string "sender_type"
    t.integer "installation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pull_request_review_comment_events", force: :cascade do |t|
    t.integer "perigren_repository_id"
    t.integer "pull_request_id"
    t.integer "review_comment_id"
    t.string "action"
    t.integer "sender_id", null: false
    t.string "sender_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sender_id"], name: "index_pull_request_review_comment_events_on_sender_id"
  end

  create_table "pull_request_review_events", force: :cascade do |t|
    t.integer "perigren_repository_id"
    t.integer "installation_id", null: false
    t.integer "pull_request_id"
    t.integer "review_id"
    t.string "action"
    t.integer "sender_id"
    t.string "sender_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["installation_id"], name: "index_pull_request_review_events_on_installation_id"
    t.index ["sender_id"], name: "index_pull_request_review_events_on_sender_id"
  end

  create_table "pull_requests", force: :cascade do |t|
    t.string "node_id"
    t.integer "number"
    t.string "state"
    t.string "title"
    t.text "body"
    t.boolean "locked"
    t.string "active_lock_reason"
    t.datetime "closed_at"
    t.datetime "merged_at"
    t.json "head"
    t.json "base"
    t.string "url"
    t.string "html_url"
    t.string "diff_url"
    t.string "patch_url"
    t.string "issue_url"
    t.string "merge_commit_sha"
    t.integer "assignee_id"
    t.integer "creator_id"
    t.string "creator_type"
    t.integer "requested_reviewers", array: true
    t.integer "requested_teams", array: true
    t.json "_links"
    t.string "author_association"
    t.bigint "perigren_repository_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assignee_id"], name: "index_pull_requests_on_assignee_id"
    t.index ["creator_id"], name: "index_pull_requests_on_creator_id"
    t.index ["node_id"], name: "index_pull_requests_on_node_id"
    t.index ["perigren_repository_id"], name: "index_pull_requests_on_perigren_repository_id"
  end

  create_table "push_events", force: :cascade do |t|
    t.string "ref"
    t.string "before"
    t.string "after"
    t.boolean "created"
    t.boolean "deleted"
    t.boolean "forced"
    t.string "base_ref"
    t.string "compare"
    t.string "head_commit"
    t.json "pusher"
    t.integer "sender_id"
    t.string "sender_type"
    t.integer "size"
    t.integer "distinct_size"
    t.integer "perigren_repository_id"
    t.string "commits", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sender_id"], name: "index_push_events_on_sender_id"
  end

  create_table "repository_comments", force: :cascade do |t|
    t.string "url"
    t.string "html_url"
    t.string "node_id"
    t.integer "owner_id"
    t.string "owner_type"
    t.integer "position"
    t.integer "line"
    t.string "path"
    t.string "commit_id"
    t.string "author_association"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["node_id"], name: "index_repository_comments_on_node_id"
    t.index ["owner_id"], name: "index_repository_comments_on_owner_id"
  end

  create_table "repository_events", force: :cascade do |t|
    t.integer "perigren_repository_id"
    t.integer "installation_id"
    t.string "action"
    t.integer "sender_id"
    t.string "sender_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["installation_id"], name: "index_repository_events_on_installation_id"
    t.index ["sender_id"], name: "index_repository_events_on_sender_id"
  end

  create_table "review_comments", force: :cascade do |t|
    t.string "url"
    t.string "node_id"
    t.text "diff_hunk"
    t.string "path"
    t.integer "position"
    t.integer "original_position"
    t.string "commit_id"
    t.string "original_commit_id"
    t.integer "in_reply_to_id"
    t.text "body"
    t.string "html_url"
    t.string "pull_request_url"
    t.json "_links"
    t.integer "pull_request_id"
    t.integer "perigren_github_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commit_id"], name: "index_review_comments_on_commit_id"
    t.index ["in_reply_to_id"], name: "index_review_comments_on_in_reply_to_id"
    t.index ["node_id"], name: "index_review_comments_on_node_id"
    t.index ["original_commit_id"], name: "index_review_comments_on_original_commit_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "commit_id"
    t.integer "perigren_github_user_id"
    t.string "node_id"
    t.text "body"
    t.datetime "submitted_at"
    t.string "state"
    t.string "html_url"
    t.string "pull_request_url"
    t.string "author_association"
    t.json "_links"
    t.bigint "pull_request_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pull_request_id"], name: "index_reviews_on_pull_request_id"
  end

  create_table "status_events", force: :cascade do |t|
    t.integer "perigren_repository_id"
    t.integer "commit_id"
    t.string "sha"
    t.string "name"
    t.string "target_url"
    t.string "context"
    t.text "description"
    t.string "state"
    t.integer "sender_id"
    t.string "sender_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sender_id"], name: "index_status_events_on_sender_id"
  end

  create_table "team_add_events", force: :cascade do |t|
    t.integer "perigren_repository_id"
    t.integer "perigren_organization_id"
    t.integer "team_id"
    t.integer "sender_id"
    t.string "sender_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sender_id"], name: "index_team_add_events_on_sender_id"
  end

  create_table "team_events", force: :cascade do |t|
    t.integer "perigren_organization_id"
    t.integer "perigren_repository_id"
    t.integer "team_id"
    t.string "action"
    t.integer "sender_id"
    t.string "sender_type"
    t.json "event_changes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sender_id"], name: "index_team_events_on_sender_id"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "perigren_organization_id"
    t.string "login"
    t.string "node_id"
    t.string "avatar_url"
    t.boolean "site_admin"
    t.string "type"
    t.string "organization_billing_email"
    t.string "name"
    t.string "slug"
    t.string "description"
    t.string "privacy"
    t.string "permission"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["node_id"], name: "index_teams_on_node_id"
  end

  add_foreign_key "commit_comment_events", "perigren_repositories"
  add_foreign_key "commit_comment_events", "repository_comments"
  add_foreign_key "create_events", "perigren_repositories"
  add_foreign_key "installation_events", "installations"
  add_foreign_key "installation_perigren_repositories_events", "installations"
  add_foreign_key "labels", "pull_requests"
  add_foreign_key "marketplace_purchase_events", "marketplace_purchases"
  add_foreign_key "marketplace_purchases", "plans"
  add_foreign_key "member_events", "perigren_repositories"
  add_foreign_key "membership_events", "perigren_organizations"
  add_foreign_key "membership_events", "teams"
  add_foreign_key "memberships", "perigren_github_users"
  add_foreign_key "organization_events", "memberships"
  add_foreign_key "organization_events", "perigren_organizations"
  add_foreign_key "pull_request_review_comment_events", "pull_requests"
  add_foreign_key "pull_request_review_comment_events", "review_comments"
  add_foreign_key "pull_request_review_events", "perigren_repositories"
  add_foreign_key "pull_request_review_events", "pull_requests"
  add_foreign_key "pull_request_review_events", "reviews"
  add_foreign_key "pull_requests", "perigren_github_users", column: "assignee_id"
  add_foreign_key "push_events", "perigren_repositories"
  add_foreign_key "repository_events", "perigren_repositories"
  add_foreign_key "review_comments", "perigren_github_users"
  add_foreign_key "review_comments", "pull_requests"
  add_foreign_key "reviews", "perigren_github_users"
  add_foreign_key "status_events", "commits"
  add_foreign_key "status_events", "perigren_repositories"
  add_foreign_key "team_add_events", "perigren_organizations"
  add_foreign_key "team_add_events", "perigren_repositories"
  add_foreign_key "team_add_events", "teams"
  add_foreign_key "team_events", "perigren_organizations"
  add_foreign_key "team_events", "perigren_repositories"
  add_foreign_key "team_events", "teams"
  add_foreign_key "teams", "perigren_organizations"
end
