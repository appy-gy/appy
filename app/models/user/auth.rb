class User
  module Auth
    extend ActiveSupport::Concern

    included do
      validates :password, length: { minimum: 6 }, presence: true, on: :create
      validates :password, confirmation: true
      validates :password_confirmation, presence: true, on: :create

      validates :email, presence: true
      validates :email, uniqueness: true
    end
  end
end
