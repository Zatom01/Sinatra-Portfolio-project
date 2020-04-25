
class Producer < ActiveRecord::Base
    has_many :movies
    has_many :posts
    has_secure_password
end
