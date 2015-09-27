class Page < ActiveRecord::Base
  extend FriendlyId

  friendly_id :title

  validates :title, :body, presence: true
end
