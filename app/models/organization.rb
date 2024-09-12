class Organization < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :boards, dependent: :destroy

  accepts_nested_attributes_for :memberships, reject_if: :all_blank
end
