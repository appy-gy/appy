module Ratings
  module Keywords
    def self.for rating
      title = rating.title
      tags = rating.tags.pluck(:name)
      section = rating.section.try(:name)
      [title, *tags, section].compact.map{ |word| word.mb_chars.downcase.to_s }.uniq
    end
  end
end
