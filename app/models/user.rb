EMAIL_REGEX =^[\\w!#$%&'*+/=?`{|}~^-]+(?:\\.[\\w!#$%&'*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$

class User < ApplicationRecord
    validates :email, uniqueness: true
    validates_format_of :email, with: EMAIL_REGEX, message: "Invalid email format"
    validates :password_digest, presence: true, length: { minimum: 6}
end
