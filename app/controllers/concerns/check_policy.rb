module CheckPolicy
  extend ActiveSupport::Concern

  class_methods do
    def check policy, *variables, **opts
      CheckPolicyDefiner.new(self, policy, variables, opts).define
    end
  end
end
