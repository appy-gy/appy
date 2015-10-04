module Ratings
  class RatingImageUploader < ImageUploader
    const :pad_color, '#21acd0'

    image :normal, [960, 500, pad_color]
    image :preview, [300, 200, pad_color]
  end
end
