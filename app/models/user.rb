class User < ApplicationRecord
    

    validates :username, presence: true, uniqueness: true
    validates :nombre, presence: true
    validates :apellido, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }, on: :create
end  
