module CustomFinder
  extend ActiveSupport::Concern

  module ClassMethods
    def find model_name, opts = {}
      model_name = model_name.to_s
      method_name = method_name model_name, opts
      define_finder model_name, method_name, opts
      add_filters method_name, opts
    end

    private

    def define_finder model_name, method_name, opts
      define_class_finder model_name, method_name, opts if opts[:polymorphic]
      if singular? model_name
        define_single_finder model_name, method_name, opts
      else
        define_multiple_finder model_name, method_name, opts
      end
    end

    def define_class_finder model_name, method_name, opts
      params_prefix = params_prefix opts
      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{method_name}_class
          @#{model_name}_class ||= params#{params_prefix}[:#{model_name}_type].constantize
        end
      CODE
    end

    def define_single_finder model_name, method_name, opts
      params_prefix = params_prefix opts
      model = opts[:polymorphic] ? "@#{model_name}_class" : model_name.camelize
      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{method_name}
          id = params#{params_prefix}[:#{model_name}_id] || params#{params_prefix}[:id]
          @#{model_name} ||= #{model}.find id
        end
      CODE
      # def find_user
      #   id = params[:user_id] || params[:id]
      #   @user ||= User.find id
      # end
    end

    def define_multiple_finder model_name, method_name, opts
      params_prefix = params_prefix opts
      model = opts[:polymorphic] ? "#{model_name}_class" : model_name.singularize.camelize
      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{method_name}
          ids = params#{params_prefix}[:#{model_name.singularize}_ids] || params#{params_prefix}[:ids]
          @#{model_name} ||= #{model}.where id: ids
        end
      CODE
      # def find_users
      #   ids = params[:user_ids] || params[:ids]
      #   @users ||= User.where id: ids
      # end
    end

    def add_filters method_name, opts
      before_action "#{method_name}_class", opts if opts[:polymorphic]
      before_action method_name, opts
    end

    def singular? word
      word.singularize == word
    end

    def method_name model_name, opts
      name = "find_#{model_name}"
      if opts.has_key? :in
        postfix = Array.wrap(opts[:in]).join('_')
        name = "#{name}_#{postfix}"
      end
      name
    end

    def params_prefix opts
      return '' unless opts.has_key?(:in)
      Array.wrap(opts[:in]).map{|name| "[:#{name}]"}.join
    end
  end
end
