module Imagination
  class Image
    attr_reader :width, :height, :format
    attr_accessor :path

    def initialize path
      self.path = path
      set_info
    end

    def name
      File.basename path
    end

    def copy
      new_path = File.join Dir.tmpdir, "#{SecureRandom.uuid}-#{name}"
      FileUtils.cp path, new_path
      merge path: new_path
    end

    def move dest
      FileUtils.cp path, dest
      FileUtils.rm path
      merge path: dest
    end

    def merge **opts
      clone.tap do |image|
        opts.each { |field, value| image.send "#{field}=", value }
      end
    end

    private

    def set_info
      identity = identify_command.run path: path + '[0]'
      @width, @height, @format = identity.split
      @width = width.to_i
      @height = height.to_i
      @format = format.downcase
    end

    def identify_command
      Cocaine::CommandLine.new 'identify', '-format "%w %h %m" :path'
    end
  end
end
