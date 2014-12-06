class Rating < ActiveRecord::Base
  belongs_to :section

  validates :title, :section, presence: true
end
