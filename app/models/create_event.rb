class CreateEvent < ApplicationRecord
  belongs_to :sender, polymorphic: true
end
