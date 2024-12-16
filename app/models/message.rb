class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validates :content, presence: true

  scope :unread, -> { where(read_at: nil) }
  scope :between_users, ->(user1_id, user2_id) do
    where("(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)",
          user1_id, user2_id, user2_id, user1_id)
  end

  def mark_as_read!
    update(read_at: Time.current) if read_at.nil?
  end
end
