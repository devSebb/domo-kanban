class User < ApplicationRecord
  has_one_attached :photo
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships, dependent: :destroy
  has_many :boards, through: :organizations, dependent: :destroy
  has_many :owned_organizations, class_name: "Organization", foreign_key: "owner_id", dependent: :destroy
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id"

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true

  def all_organizations
    (owned_organizations + organizations).uniq
  end
end
