module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :param

      def initialize(method, path, controller, action, param = nil)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @param = param
        replace_path_for_param
      end

      def match?(method, path)
        @method == method && path.match(Regexp.new("^#{@path}$"))
      end

      def replace_path_for_param
        @path.gsub!(@param, '\d+') if @param
      end

    end
  end
end
