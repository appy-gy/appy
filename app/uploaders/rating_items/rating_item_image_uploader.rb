module RatingItems
  class RatingItemImageUploader < ImageUploader
    image :normal, [840, 385]

    def filename
      return unless super.present?
      @name ||= super.sub File.extname(super), '.jpg'
    end
  end
end
