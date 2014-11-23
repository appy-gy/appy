module Serializer
  class Smart < Base
    def serialize **opts
      find_serializer.new(data).serialize(opts)
    end

    private

    def find_serializer
      case item
      when ::Array then Serializer::Array
      when ActiveRecord::Relation then Serializer::Relation
      else Serializer::Object
      end
    end
  end
end
