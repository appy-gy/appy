class BrowserNotificationSubscription < ActiveRecord::Base
  belongs_to :user

  enum browser: %w{chrome firefox}

  validates :browser, :endpoint, presence: true
  validates :endpoint, uniqueness: { scope: :browser }
end
