class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :organization, optional: true
  belongs_to :board, optional: true

  enum role: [ :member, :admin ]
end
