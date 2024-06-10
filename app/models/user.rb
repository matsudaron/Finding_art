class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_boards, through: :bookmarks, source: :board

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :email, uniqueness: true
  validates :email, presence: true

  def own?(object)
    object.user_id == id
  end

  def bookmark(board)
    bookmarks.create(board: board)
  end

  def unbookmark(board)
    bookmarks.find_by(board_id: board.id)&.destroy
  end

  def bookmark?(board)
    bookmarked_boards.include?(board)
  end
end
