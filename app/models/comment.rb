class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :rating
  belongs_to :parent, class_name: 'Comment'
  has_many :children, foreign_key: :parent_id, class_name: 'Comment'

  validates :body, :user, :rating, null: false
end
