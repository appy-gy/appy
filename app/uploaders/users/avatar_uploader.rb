module Users
  class AvatarUploader < ImageUploader
    const :pad_color, :white

    image :normal, [480, 480, pad_color]
    image :small, [100, 100, pad_color]
  end
end
