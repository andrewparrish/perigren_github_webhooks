class Commit < ApplicationRecord
  belongs_to :author, polymorphic: true
  belongs_to :committer,  polymorphic: true
end
