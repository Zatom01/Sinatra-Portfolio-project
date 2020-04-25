
class Producer < ActiveRecord::Base
    has_many :movies
    has_many :posts
    has_secure_password
    validates :username, :presence => true, :uniqueness => true
end
