module Serializer
  class Relation < Base
    private

    def serialization **opts
      -> do
        serializer = opts.fetch(:serializer) { find_serializer }
        opts.merge! each_serializer: serializer
        ActiveModel::ArraySerializer.new(relation, opts).as_json
      end
    end

    def class_name
      relation.model.name
    end
  end
end
