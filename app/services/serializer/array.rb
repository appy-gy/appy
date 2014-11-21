module Serializer
  class Array < Base
    private

    def serialization **opts
      -> do
        return [].as_json if array.empty?
        serializer = opts.fetch(:serializer) { find_serializer }
        opts.merge! each_serializer: serializer
        ActiveModel::ArraySerializer.new(array, opts).as_json
      end
    end

    def class_name
      array.first.class.name
    end
  end
end
