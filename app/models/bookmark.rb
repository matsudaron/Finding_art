class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates :user_id, presence: true, uniqueness: { scope: :board_id }
  validates :board_id, presence: true
end
