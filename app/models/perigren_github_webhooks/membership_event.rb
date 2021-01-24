module PerigrenGithubWebhooks
  class MembershipEvent < ApplicationRecord
    belongs_to :sender, polymorphic: true
    belongs_to :member, polymorphic: true
  end
end
