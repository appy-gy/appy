module CustomFinder
  extend ActiveSupport::Concern

  class_methods do
    def find model_name, **opts
      CustomFinderDefiner.new(self, model_name, opts).define
    end
  end
end
