class AdminUser < ApplicationRecord
  # enum role: [:user, :admin]
  # after_initialize :set_default_role, :if => :new_record?

  # def set_default_role
  #   self.role ||= :user
  # end

  # validates :name, presence: true
  # validates :role, presence: true, numericality: { only_integer: true }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
  attr_accessor :email, :password, :password_confirmation,
                  :remember_me
end
