class PushEvent < ApplicationRecord
  belongs_to :sender, polymorphic: true
end
