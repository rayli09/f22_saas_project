class User < ActiveRecord::Base
    has_secure_password
    has_many :comments, :dependent => :destroy #TODO this is placeholder for comments in T2
end
