module RatingItems
  class RatingItemImageUploader < ImageUploader
    image :normal, [880, nil, :white], resize: :resize_and_pad
  end
end
