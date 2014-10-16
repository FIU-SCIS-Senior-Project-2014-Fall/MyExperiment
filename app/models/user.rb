class User < ActiveRecord::Base
    validates :name,  prescence: true, length: { maximum: 50}

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, prescence: true, format { with: VALID_EMAIL_REGEX },
                      uniqueness: {case_sensitive: false }

    before_save { self.email = email.downcase }

    has_many :models
end
