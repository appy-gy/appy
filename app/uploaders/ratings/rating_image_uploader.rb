module Ratings
  class RatingImageUploader < ImageUploader
    process convert: 'jpg'

    image :normal, [950, 500]
    image :small, [300, 200]

    def filename
      return unless super.present?
      @name ||= super.sub File.extname(super), '.jpg'
    end
  end
end
