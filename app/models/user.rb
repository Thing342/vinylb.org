class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :albums, dependent: :destroy

  before_save { self.email.downcase! }
  has_secure_password

  validates :name,
      presence: true,
      length: { maximum: 50 }
  validates :email,
      presence: true,
      length: { maximum: 255 },
      format: { with: VALID_EMAIL_REGEX },
      uniqueness: { case_sensitive: false }
  validates :password,
      presence: true,
      length: { minimum: 6 },
      allow_nil: true

end