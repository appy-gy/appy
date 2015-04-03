module Users
  class AvatarUploader < ImageUploader
    process convert: 'jpg'

    image :normal, [480, 480]
    image :small, [100, 100]

    def filename
      return unless super.present?
      @name ||= super.sub File.extname(super), '.jpg'
    end
  end
end
