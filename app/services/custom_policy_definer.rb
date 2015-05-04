class CustomPolicyDefiner
  attr_reader :controller, :policy, :variables, :opts

  def initialize controller, policy, variables, **opts
    @controller = controller
    @policy = policy.to_s
    @variables = variables
    @opts = opts
  end

  def define
    define_check
    add_filter
  end

  private

  def define_check
    controller.class_eval <<-CODE, __FILE__, __LINE__ + 1
      def #{method_name}
        policy = #{policy}.new current_user, #{variables.join(', ')}
        render_error policy.error unless policy.call
      end
    CODE
  end

  def add_filter
    controller.before_action method_name, opts
  end

  def method_name
    @method_name ||= policy.underscore.gsub('/', '__').prepend('check_')
  end
end
