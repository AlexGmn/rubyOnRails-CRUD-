class User < ApplicationRecord
    has_secure_password

    validates :nombre, presence: true
    validates :apellido, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true, confirmation: true
    
    #after_create :check_approved_status

    private

    #def check_approved_status
     #   unless approved
      #  self.destroy
       # end
    #end

    def set_default_approved
        self.approved = true if self.approved.nil?
    end

end  
