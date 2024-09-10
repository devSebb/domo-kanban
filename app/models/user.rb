class User < ApplicationRecord
  has_many :memberships
  has_many :organizations, through: :memberships
  has_many :boards, through: :organizations


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
