module Ratings
  class RatingImageUploader < ImageUploader
    const :pad_color, '#21acd0'

    image :normal, [950, 500, pad_color], resize: :resize_and_pad
    image :large_preview, [630, 400, pad_color], resize: :resize_and_pad
    image :preview, [300, 200, pad_color], resize: :resize_and_pad

    def filename
      return unless super.present?
      @name ||= super.sub File.extname(super), '.jpg'
    end
  end
end
