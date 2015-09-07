module Ionicons
  class EachLine
    attr_reader :str

    def initialize str
      @str = str
    end

    def icons
      return [] if icon_position.nil?
      items.map { |item| item[icon_position] }
    end

    private

    def icon_position
      @icon_position ||= str.split(' in ').first.split(/[\s,]+/).select{ |part| part.starts_with? '$' }.find_index('$icon')
    end

    def items
      str.split(' in ').last.scan(/\((.*?)\)/).map(&:first).map{ |item| item.split(/[\s,]+/) }
    end
  end
end
