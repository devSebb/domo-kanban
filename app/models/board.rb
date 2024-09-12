class Board < ApplicationRecord
  belongs_to :organization
  has_many :lists, dependent: :destroy
  has_many :cards, through: :lists, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships, dependent: :destroy
end
