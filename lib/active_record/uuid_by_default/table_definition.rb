module ActiveRecord
  module UuidByDefault
    module TableDefinition
      def references *args
        options = args.extract_options!
        options[:type] ||= :uuid
        args << options

        super *args
      end
      alias :belongs_to :references
    end
  end
end
