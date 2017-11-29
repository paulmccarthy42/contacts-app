class User < ApplicationRecord
  has_many :contacts
  has_secure_password
end
