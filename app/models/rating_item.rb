class RatingItem < ActiveRecord::Base
  include Imagination::Field

  attr_accessor :vote, :video_url

  image :image, versions: { normal: [880, nil] }, resize: :resize_to_limit

  belongs_to :rating
  has_many :votes, dependent: :destroy

  validates :position, :mark, :rating, presence: true
  validates :position, uniqueness: { scope: :rating }

  before_validation :get_video_info, if: -> { not video_url.nil? }
  before_validation :set_image_size, if: :image_changed?

  private

  def get_video_info
    self.video = RatingItems::GetVideoInfo.new(video_url).call
    self.video_url = nil
  end

  def set_image_size
    return unless self.image?
    image = Imagination::Image.new image_path(:normal_1x)
    self.image_width = image.width
    self.image_height = image.height
  end
end
