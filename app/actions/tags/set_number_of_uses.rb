module Tags
  class SetNumberOfUses
    attr_reader :tags

    def initialize tags
      @tags = tags
    end

    def call
      tags_map = tags.map(&:id).zip(tags).to_h
      RatingsTag.about(tags).group(:tag_id).count.each do |tag_id, count|
        tags_map[tag_id].number_of_uses = count
      end
    end
  end
end
