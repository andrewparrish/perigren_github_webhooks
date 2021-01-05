class InstallationEvent < ApplicationRecord
  belongs_to :sender, polymorphic: true
end
