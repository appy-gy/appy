class SearchResultsSerializer < ActiveModel::ArraySerializer
  self.root = :results

  def serializable_array
    object.map do |result|
      serializer = "#{result.class.name}ForSearchSerializer".constantize
      serializable = serializer.new result, options.merge(root: false)
      serializable.as_json.merge(type: result.class.name.downcase)
    end
  end
end
