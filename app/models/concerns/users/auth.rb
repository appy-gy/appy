module Users
  module Auth
    extend ActiveSupport::Concern

    included do
      authenticates_with_sorcery! do |config|
        config.authentications_class = Authentication
      end

      validates :password, presence: true, on: :create
      validates :password, length: { minimum: 6 }, if: :password
      validates :email, presence: true, uniqueness: true

      has_many :authentications, dependent: :destroy
    end
  end
end
