class RepositoryComment < ApplicationRecord
  belongs_to :owner, polymorphic: true
end
