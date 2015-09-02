class ImageUploader < BaseUploader
  include CarrierWave::MiniMagick
  include CarrierWave::Processing::MiniMagick
  include CarrierWave::Mozjpeg

  # Replace #resize_to_fill to allow pass a background argument
  # Original source:
  # https://github.com/carrierwaveuploader/carrierwave/blob/master/lib/carrierwave/processing/mini_magick.rb#L176

  def resize_to_fill width, height, background = 'rgba(255, 255, 255, 0.0)', gravity = 'Center'
    manipulate! do |img|
      cols, rows = img[:dimensions]
      img.combine_options do |cmd|
        if width != cols || height != rows
          scale_x = width/cols.to_f
          scale_y = height/rows.to_f
          if scale_x >= scale_y
            cols = (scale_x * (cols + 0.5)).round
            rows = (scale_x * (rows + 0.5)).round
            cmd.resize "#{cols}"
          else
            cols = (scale_y * (cols + 0.5)).round
            rows = (scale_y * (rows + 0.5)).round
            cmd.resize "x#{rows}"
          end
        end
        cmd.gravity gravity
        cmd.background background
        cmd.extent "#{width}x#{height}" if cols != width || rows != height
      end
      img = yield(img) if block_given?
      img
    end
  end

  def self.image name, resize_params, resize: :resize_to_fill, quality: 80, format: 'jpg'
    version name do
      process :strip
      process resize => resize_params
      process convert: format
      process mozjpeg: quality if format == 'jpg'

      define_method :full_filename do |for_file|
        name = super for_file
        "#{name.chomp File.extname(name)}.#{format}"
      end
    end
  end
end
