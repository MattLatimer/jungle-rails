class User < ActiveRecord::Base
  
  has_many :reviews
  
  has_secure_password

  validates :email, presence: true,
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
                       confirmation: true,
                       length: { minimum: 8 }
  validates :password_confirmation, presence: true
  validates :name, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

end
