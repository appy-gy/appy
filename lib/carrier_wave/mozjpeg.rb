module CarrierWave
  module Mozjpeg
    def mozjpeg quality
      cache_stored_file! unless cached?
      ext = File.extname current_path
      tmp_path = Pathname.new(current_path).dirname.join("tmp#{ext}").to_s
      File.rename current_path, tmp_path
      line.run quality: quality.to_s, inputfile: tmp_path, outfile: current_path
      File.delete tmp_path
    end

    private

    def line
      @line ||= Cocaine::CommandLine.new cjpeg_path, '-quality :quality -outfile :outfile :inputfile'
    end

    def cjpeg_path
      ENV.fetch 'TOP_CJPEG_PATH', 'cjpeg'
    end
  end
end
