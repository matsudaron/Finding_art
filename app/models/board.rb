class Board < ApplicationRecord
  mount_uploader :board_image, BoardImageUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  geocoded_by :address
  after_validation :geocode

  validates :title, presence: true, length: { maximum: 255, minimum: 3 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :address, presence: true
  validate :validate_latitude_and_longitude

  def self.ransackable_attributes(auth_object = nil)
    ["board_image", "body", "created_at", "id", "title", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["bookmarks", "comments", "user"]
  end

  private

  def validate_latitude_and_longitude
    if latitude.blank? || longitude.blank?
      errors.add(:address)
    end
  end
end
