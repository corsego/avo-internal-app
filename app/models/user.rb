class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  before_validation :set_password, on: :create

  def set_password
    self.password = SecureRandom.hex
  end

  after_create_commit do
    PasswordsMailer.reset(self).deliver_later
  end
end
