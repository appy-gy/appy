class BrowserNotification < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true

  scope :recent, -> { where 'created_at > ?', 30.minutes.ago }
  scope :of, -> user { where user: user }
end
