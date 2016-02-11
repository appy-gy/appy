class BrowserNotification < ActiveRecord::Base
  include Redis::Objects

  set :fetcher_ids
  set :clicker_ids

  store_accessor :payload, :title, :body, :icon, :tag, :url

  validates :title, :body, :icon, :tag, :url, presence: true

  scope :for, -> subscription { where 'subscription_ids @> ARRAY[?]::uuid[]', subscription.id }

  before_validation :set_icon, on: :create
  before_validation :set_tag, on: :create

  def recipients
    BrowserNotificationSubscription.where id: subscription_ids
  end

  def fetchers
    BrowserNotificationSubscription.where id: fetcher_ids.get
  end

  def clickers
    BrowserNotificationSubscription.where id: clicker_ids.get
  end

  private

  def set_icon
    self.icon = "#{ENV['TOP_ASSETS_HOST']}/files/favicon.png"
  end

  def set_tag
    self.tag = SecureRandom.uuid
  end
end
