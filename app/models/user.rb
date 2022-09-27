class User < ApplicationRecord

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false}
  validates :password, presence: true, confirmation: true, length: {minimum: 6}

  before_save :downcase_fields

  def downcase_fields
    self.email.downcase
  end

  def self.authenticate_with_credentials(email, password)
    base_email = email.strip.downcase
    user = User.find_by_email(base_email)

    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

end
