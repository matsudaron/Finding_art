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
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

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

  def deliver_reset_password_instructions!
    mail = false
    config = sorcery_config
    # hammering protection
    return false if config.reset_password_time_between_emails.present? && send(config.reset_password_email_sent_at_attribute_name) && send(config.reset_password_email_sent_at_attribute_name) > config.reset_password_time_between_emails.seconds.ago.utc
  
    self.class.sorcery_adapter.transaction do
      generate_reset_password_token!
      mail = send_reset_password_email! unless config.reset_password_mailer_disabled
    end
    mail
  end

  def load_from_reset_password_token(token, &block)
    load_from_token(
      token,
      @sorcery_config.reset_password_token_attribute_name,
      @sorcery_config.reset_password_token_expires_at_attribute_name,
      &block
    )
  end

  def change_password(new_password, raise_on_failure: false)
    clear_reset_password_token
    send(:"#{sorcery_config.password_attribute_name}=", new_password)
    sorcery_adapter.save raise_on_failure: raise_on_failure
  end
end
