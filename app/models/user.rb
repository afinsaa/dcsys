class User < ApplicationRecord
  has_many :parents, class_name: "parent", foreign_key: "user_id"
  belongs_to :school, optional: true
  # has_one :student, through: :parent, source: :user_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         UserTypes = [:Admin, :Moderator ,:Teacher, :Parent]
         ROLES = %i[Admin Moderator Teacher Parent]

         def roles=(roles)
          roles = [*roles].map { |r| r.to_sym }
          self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
        end
      
        def roles
          ROLES.reject do |r|
            ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
          end
        end
        def has_role?(role)
          roles.include?(role)
        end


end
