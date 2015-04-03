module Users
  class AvatarUploader < ImageUploader
    image :normal, [480, 480]
    image :small, [100, 100]
  end
end
