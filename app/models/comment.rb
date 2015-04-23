class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :rating
  belongs_to :parent, class_name: 'Comment'

  validates :body, :user, :rating, :parent, null: false
end
