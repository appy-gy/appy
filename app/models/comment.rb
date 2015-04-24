class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :rating
  belongs_to :parent, class_name: 'Comment'
  has_many :children, foreign_key: :parent_id, class_name: 'Comment', dependent: :destroy

  validates :body, :user, :rating, presence: true
end
