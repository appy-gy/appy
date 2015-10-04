require 'mkmf'

module Ionicons
  class FontGenerator
    const :tools, %w{fontforge sfnt2woff}
    const :fonts_path, Rails.root.join('frontend/fonts')
    const :styles_path, Rails.root.join('frontend/styles')
    const :repo_path, Pathname.new(__dir__).join('ionicons')
    const :repo_url, 'git@github.com:driftyco/ionicons.git'

    def call
      check_tools
      with_repo do
        remove_unused_svgs
        build_font
        copy_font
      end
    end

    private

    def check_tools
      missing = tools.reject { |tool| find_executable tool }
      return if missing.empty?
      raise StandardError.new("One or more of the required tools are missing: #{missing.join(', ')}. Install them first")
    end

    def remove_unused_svgs
      Dir.glob(repo_path.join('src/*.svg'))
        .reject { |path| icons.include? path.split('/').last.chomp('.svg') }
        .each { |path| File.delete path }
    end

    def build_font
      system "python #{repo_path.join('builder/generate.py')}"
    end

    def copy_font
      FileUtils.cp repo_path.join('fonts/ionicons.woff'), fonts_path
    end

    def icons
      @icons ||= begin
        direct_icons = styles.lines
          .select { |line| line.include? '+ion-icon' }
          .map { |line| line.match(/ion-icon\((?:(?:'|"))?(.*?)(?:(?:'|"))?\)/)[1] }
          .reject { |icon| icon.starts_with? '$' }

        each_icons = styles.lines
          .select { |line| line.include? '@each' }
          .flat_map { |line| EachLine.new(line).icons }

        (direct_icons + each_icons).to_set
      end
    end

    def styles
      @styles ||= Dir.glob(styles_path.join('**/*.sass')).map{ |path| File.read path }.join("\n")
    end

    def with_repo
      clone_repo
      yield
      remove_repo
    end

    def clone_repo
      system "git clone #{repo_url} #{repo_path}"
    end

    def remove_repo
      FileUtils.rm_r repo_path
    end
  end
end
