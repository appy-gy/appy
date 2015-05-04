module CheckPolicy
  extend ActiveSupport::Concern

  class_methods do
    def check policy, *variables, **opts
      CustomPolicyDefiner.new(self, policy, variables, opts).define
    end
  end

  def render_error error
    render json: error, status: 400
  end
end
