class BrowserNotificationSubscription < ActiveRecord::Base
  belongs_to :user

  enum browser: %w{chrome firefox}

  validates :browser, :user, presence: true
  validates :user_id, uniqueness: true
end
