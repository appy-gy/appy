module Users
  class AvatarGenerator
    const :size, AvatarUploader.images[:normal][:sizes].first
    const :generator_url, 'http://api.adorable.io/avatar'

    def generate
      Tempfile.open [id, '.png'] do |file|
        file.binmode
        file.write avatar
        yield file
      end
    end

    private

    def avatar
      @avatar ||= HTTParty.get(url).body
    end

    def id
      @id ||= SecureRandom.uuid
    end

    def url
      @url ||= File.join generator_url, size.to_s, id
    end
  end
end
