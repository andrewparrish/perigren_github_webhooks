class StatusEvent < ApplicationRecord
  belongs_to :sender, polymorphic: true
end
