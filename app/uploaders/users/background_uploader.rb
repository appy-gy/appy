module Users
  class AvatarUploader < ImageUploader
    const :pad_color, '#21acd0'

    image :normal, [960, 374, pad_color]
  end
end
