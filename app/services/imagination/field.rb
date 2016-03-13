module Imagination
  module Field
    extend ActiveSupport::Concern

    class_methods do
      def image field, **opts
        const :"#{field}_options", opts

        class_eval <<~RUBY, __FILE__, __LINE__ + 1
          attr_accessor :#{field}_upload, :remove_#{field}

          before_save :process_#{field}
          before_save :clear_#{field}

          def #{field}= value
            return self.#{field}_upload = value if Imagination::Processor.processable? value
            super value
          end

          def process_#{field}
            return unless #{field}_upload
            Imagination::Processor.new(self, :#{field}, #{field}_options).process
          end

          def clear_#{field}
            return unless remove_#{field}
            self.remove_#{field} = nil
            self.#{field} = nil
          end

          def #{field}_url version = nil
            return unless #{field}?
            Imagination::Pathfinder.url self, :#{field}, version
          end

          def #{field}_path version = nil
            return unless #{field}?
            Imagination::Pathfinder.path self, :#{field}, version
          end
        RUBY
      end
    end
  end
end
