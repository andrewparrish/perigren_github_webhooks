class RepositoryEvent < ApplicationRecord
  belongs_to :sender, polymorphic: true
end
