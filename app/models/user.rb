class User < ActiveRecord::Base
  has_secure_password
  has_many :review

  before_save :check_data

  private

    def check_data

      if User.find_by_email(self.email)
        errors.add(:email, "already exists")
        false
        # throw :abort
      end
    end
end
