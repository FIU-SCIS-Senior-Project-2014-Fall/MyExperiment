class User < ActiveRecord::Base
    # downcase email for db
    before_save { self.email = email.downcase }

    # name validation
    validates :name,  presence: true, length: { maximum: 50 }

    # email validation
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }

    has_secure_password

    # password validation
    validates :password, length: { minimum: 6}
    
    has_many :models
end
