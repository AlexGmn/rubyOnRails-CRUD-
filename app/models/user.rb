class User < ApplicationRecord
    has_secure_password

    validates :username, presence: true, uniqueness: true
    validates :nombre, presence: true
    validates :apellido, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true, length: { minimum: 6 }, on: :create
    
end  
