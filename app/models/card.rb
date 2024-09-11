class Card < ApplicationRecord
  belongs_to :list
  belongs_to :assigned_user, class_name: "User", optional: true
  has_many :labels
  acts_as_list scope: :list
end
