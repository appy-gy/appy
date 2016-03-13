module Imagination
  class File
    attr_reader :file

    def initialize file
      @file = file
    end

    def path
      file.path
    end

    def filename
      case file
      when ::File then ::File.basename file
      when ActionDispatch::Http::UploadedFile then file.original_filename
      end
    end
  end
end
