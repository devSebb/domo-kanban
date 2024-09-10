class Card < ApplicationRecord
  belongs_to :list
  belongs_to :assigned_user
end
