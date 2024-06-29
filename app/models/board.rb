class Board < ApplicationRecord
  mount_uploader :board_image, BoardImageUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255, minimum: 3 }
  validates :body, presence: true, length: { maximum: 65_535 }

  def self.ransackable_attributes(auth_object = nil)
    ["board_image", "body", "created_at", "id", "title", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["bookmarks", "comments", "user"]
  end

  def bookmarks_count
    bookmarks.count
  end
end
