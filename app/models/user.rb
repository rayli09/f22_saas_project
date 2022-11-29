class User < ActiveRecord::Base
    has_secure_password
    has_many :comments, :dependent => :destroy
    has_and_belongs_to_many :events

    def self.from_omniauth(auth)
        where(email: auth.info.email).first_or_initialize do |user|
          user.username = auth.info.name
          user.email = auth.info.email
          user.password = SecureRandom.hex
        end
    end
    def promote_event
      if self.coins >= 10
        update_attribute(:coins, self.coins - 10)
        return true
      end
      return false
    end
end