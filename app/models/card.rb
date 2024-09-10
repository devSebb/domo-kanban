class Card < ApplicationRecord
  belongs_to :list
  belongs_to :assigned_user, class_name: "User", optional: true
  has_many :labels
end
