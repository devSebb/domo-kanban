class Board < ApplicationRecord
  belongs_to :organization
  has_many :lists
  has_many :cards, through: :lists
  has_many :memberships
  has_many :users, through: :memberships
end
