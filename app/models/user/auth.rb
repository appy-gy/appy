module User::Auth
  extend ActiveSupport::Concern

  included do
    validates :password, length: { minimum: 6 }
    validates :password, confirmation: true
    validates :password_confirmation, presence: true
    
    validates :email, presence: true
    validates :email, uniqueness: true
  end
end
