class User < ApplicationRecord
  has_many :memberships
  has_many :organizations, through: :memberships
  has_many :boards, through: :organizations
  has_many :owned_organizations, class_name: "Organization", foreign_key: "owner_id"


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
