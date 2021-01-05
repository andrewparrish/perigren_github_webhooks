class InstallationRepositoriesEvent < ApplicationRecord
  belongs_to :sender, polymorphic: true
end
