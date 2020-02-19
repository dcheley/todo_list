class User < ApplicationRecord
  validates :email, presence: true
  validates :email, uniqueness: true

  has_many :to_dos

  has_secure_password
end
