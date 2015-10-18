class RatingItem < ActiveRecord::Base
  attr_accessor :vote, :video_url

  mount_uploader :image, RatingItems::RatingItemImageUploader

  belongs_to :rating
  has_many :votes, dependent: :destroy

  validates :position, :mark, :rating, presence: true
  validates :position, uniqueness: { scope: :rating }

  before_validation :get_video_info, if: -> { not video_url.nil? }

  private

  def get_video_info
    self.video = RatingItems::GetVideoInfo.new(video_url).call
    self.video_url = nil
  end
end
