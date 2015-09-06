module RatingItems
  class RatingItemImageUploader < ImageUploader
    image :normal, [960, nil, :white], resize: :resize_and_pad

    def filename
      return unless super.present?
      @name ||= super.sub File.extname(super), '.jpg'
    end
  end
end
