class BasePolicy
  class << self
    def arguments *args
      @arguments = args.unshift :current_user
      attr_reader *@arguments
      define_initialize
    end

    private

    def define_initialize
      methods_module.module_eval <<-CODE, __FILE__, __LINE__ + 1
        def initialize #{@arguments.join(', ')}
          #{@arguments.map{ |arg| "@#{arg} = #{arg}" }.join("\n")}
        end
      CODE
    end

    def methods_module
      @methods_module ||= Module.new.tap do |mod|
        include mod
      end
    end
  end

  attr_reader :error

  def fail! error = nil
    @error = error
    false
  end
end
