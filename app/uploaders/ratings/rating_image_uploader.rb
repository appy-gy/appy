module Ratings
  class RatingImageUploader < ImageUploader
    const :pad_color, '#21acd0'

    image :normal, [960, 500, pad_color]
    image :large_preview, [630, 400, pad_color]
    image :preview, [300, 200, pad_color]

    def filename
      return unless super.present?
      @name ||= super.sub File.extname(super), '.jpg'
    end
  end
end
