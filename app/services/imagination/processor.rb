require 'imagination/image'

module Imagination
  class Processor
    attr_reader :record, :field, :opts

    const :default_opts, {
      versions: [],
      sizes: [1, 2],
      quality: 80,
      resize: :resize_to_fill,
      pad_color: 'white'
    }

    const :processable_classes, [File, ActionDispatch::Http::UploadedFile]

    def initialize record, field, **opts
      raise ArgumentError.new('Record should have id') unless record.id?
      @record = record
      @field = field
      @opts = default_opts.merge opts
    end

    def process
      record.public_send "#{field}=", upload.filename
      FileUtils.mkdir_p dir
      FileUtils.cp upload.path, path
      process_versions
    end

    def self.processable? object
      processable_classes.include? object.class
    end

    protected

    def process_versions
      threads = opts[:versions].map do |name, (width, height)|
        opts[:sizes].map do |size|
          Thread.new do
            dest = File.join dir, "#{name}_#{size}x_#{upload.filename}"
            process_version dest, width, height
          end
        end
      end
      threads.flatten.each(&:join)
    end

    def process_version dest, width, height
      image = self.image.copy
      image = convert image, width, height
      image = mozjpeg image
      image.move dest
    end

    def convert image, width, height
      new_path = Pathname.new(image.path).sub_ext('.jpg').to_s
      convert_command.run pad_color: opts[:pad_color], resize: send("#{opts[:resize]}_dimensions", image, width, height), path: image.path + '[0]', new_path: new_path
      FileUtils.rm image.path unless image.path == new_path
      image.merge path: new_path
    end

    def mozjpeg image
      return image unless use_mozjpeg?
      image_copy = image.copy
      cjpeg_command.run quality: opts[:quality], path: image_copy.path, new_path: image.path
      FileUtils.rm image_copy.path
      image
    end

    def resize_to_fill_dimensions image, width, height
      [width, height].compact.join('x').concat('>')
    end

    def resize_to_limit_dimensions image, width, height
      scale_x = width.to_f / image.width
      scale_y = height.to_f / image.height
      if scale_x >= scale_y
        "#{(scale_x * (image.width + 0.5)).round}"
      else
        "x#{(scale_y * (image.height + 0.5)).round}"
      end
    end

    def upload
      @upload ||= Upload.new record.public_send("#{field}_upload")
    end

    def dir
      Pathfinder.dir record, field
    end

    def path
      Pathfinder.path record, field
    end

    def image
      @image ||= Image.new path
    end

    def convert_command
      Cocaine::CommandLine.new 'convert', '-strip -format jpg -quality 100 -background :pad_color -alpha remove -resize :resize -gravity Center :path :new_path'
    end

    def cjpeg_command
      Cocaine::CommandLine.new cjpeg_path, '-quality :quality -outfile :new_path :path'
    end

    def cjpeg_path
      ENV.fetch 'TOP_CJPEG_PATH', 'cjpeg'
    end

    def use_mozjpeg?
      ENV['TOP_USE_MOZJPEG'] == 'true'
    end
  end
end
