class User < ActiveRecord::Base
    # downcase email for db
    before_save { self.email = email.downcase }

    # name validation
    validates :name,  prescence: true, length: { maximum: 50}

    # email validation
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, prescence: true, format { with: VALID_EMAIL_REGEX },
                      uniqueness: {case_sensitive: false }

    has_secure_password

    # password validation
    validates :password, length: { minimum: 6}
    
    has_many :models
end
