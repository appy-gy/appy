class Rating < ActiveRecord::Base
  validates :title, presence: true
end
