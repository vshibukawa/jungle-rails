class User < ActiveRecord::Base
  has_secure_password
  has_many :review

  before_save :check_data

  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }
  validates :password_confirmation, length: { minimum: 8 }
  validates_presence_of :first_name, :last_name, :email, :password, :password_confirmation

  def self.authenticate_with_credentials (email, password)
    user = find_by_email(email.lstrip.rstrip.downcase)
    user.authenticate(password) if user
  end

  private

    def check_data
      self.email.lstrip.rstrip.downcase!
      if User.find_by_email(self.email)
        errors.add(:email, "already exists")
        false
        # throw :abort
      end
    end

end
