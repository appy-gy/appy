module User::Auth
  extend ActiveSupport::Concern

  included do
    validates :password, confirmation: true
    validates :password, length: { minimum: 6 }, presence: true, on: :create
    validates :email, presence: true
    validates :email, uniqueness: true
  end
end
