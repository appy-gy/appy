module RatingItems
  class RatingItemImageUploader < ImageUploader
    image :normal, [880, nil], resize: :resize_to_limit
  end
end
