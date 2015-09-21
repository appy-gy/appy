class Page < ActiveRecord::Base
  extend FriendlyId

  friendly_id :id

  validates :body, presence: true
end
