module Users
  module Auth
    extend ActiveSupport::Concern

    included do
      authenticates_with_sorcery! do |config|
        config.authentications_class = Authentication
      end

      validates :password, presence: true, on: :create
      validates :password, length: { minimum: 1 }, if: :password
      validates :email, presence: true, uniqueness: true

      has_many :authentications, dependent: :destroy

      def generate_password
        return if password
        self.password = SecureRandom.uuid
      end

      def generate_email
        return if email?
        self.email = "#{SecureRandom.uuid.first(8)}@fake.com"
      end
    end
  end
end
