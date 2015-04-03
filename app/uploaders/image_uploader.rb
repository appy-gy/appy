class ImageUploader < BaseUploader
  include CarrierWave::MiniMagick
  include CarrierWave::Processing::MiniMagick

  def self.image name, sizes, resize: :resize_to_fill, quality: 80, format: 'jpg'
    version name do
      process :strip
      process resize => sizes
      process quality: quality
      process convert: format

      define_method :full_filename do |for_file|
        name = super for_file
        "#{name.chomp File.extname(name)}.#{format}"
      end
    end
  end
end
