class CustomFinderDefiner
  attr_reader :controller, :model_name, :opts

  def initialize controller, model_name, **opts
    @controller = controller
    @model_name = model_name.to_s
    @opts = opts
  end

  def define
    define_finder
    add_filters
  end

  private

  def define_finder
    define_class_finder if opts[:polymorphic]
    singular?(model_name) ? define_single_finder : define_multiple_finder
  end

  def define_class_finder
    controller.class_eval <<-CODE, __FILE__, __LINE__ + 1
      def #{method_name}_class
        @#{model_name}_class ||= params#{params_prefix}[:#{model_name}_type].constantize
      end
    CODE
  end

  def define_single_finder
    controller.class_eval <<-CODE, __FILE__, __LINE__ + 1
      def #{method_name}
        id = params#{params_prefix}[:#{model_name}_id] || params#{params_prefix}[:id]
        @#{model_name} ||= #{model_class}.find id
      end
    CODE
    # def find_user
    #   id = params[:user_id] || params[:id]
    #   @user ||= User.find id
    # end
  end

  def define_multiple_finder
    controller.class_eval <<-CODE, __FILE__, __LINE__ + 1
      def #{method_name}
        ids = params#{params_prefix}[:#{model_name.singularize}_ids] || params#{params_prefix}[:ids]
        @#{model_name} ||= #{model_class}.where id: ids
      end
    CODE
    # def find_users
    #   ids = params[:user_ids] || params[:ids]
    #   @users ||= User.where id: ids
    # end
  end

  def add_filters
    controller.before_action "#{method_name}_class", opts if opts[:polymorphic]
    controller.before_action method_name, opts
  end

  def singular? word
    word.singularize == word
  end

  def method_name
    @method_name ||= "find_#{model_name}".tap do |name|
      name << "_#{Array.wrap(opts[:in]).join('_')}" if opts[:in]
    end
  end

  def model_class
    @model_class ||= opts[:polymorphic] ? "#{model_name}_class" : model_name.singularize.camelize
  end

  def params_prefix
    @params_prefix ||= Array.wrap(opts[:in]).map{|name| "[:#{name}]"}.join
  end
end
