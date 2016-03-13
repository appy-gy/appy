module Imagination
  class Upload
    attr_reader :file

    def initialize file
      @file = file
    end

    def path
      file.path
    end

    def filename
      @filename ||= file.original_filename || SecureRandom.uuid
    end
  end
end
