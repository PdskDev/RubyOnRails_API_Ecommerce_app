class User < ApplicationRecord
    validates :email, uniqueness: true
    validates_format_of :email, with: /@/, message: "Invalid email format"
    validates :password_digest, presence: true, length: { minimum: 6}
    has_secure_password
end
