class User
  module Auth
    extend ActiveSupport::Concern

    included do
      authenticates_with_sorcery!

      validates :password, presence: true, on: :create
      validates :password, length: { minimum: 6 }, if: :password

      validates :email, presence: true, uniqueness: true
    end
  end
end
