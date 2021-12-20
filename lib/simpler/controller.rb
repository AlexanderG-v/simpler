require_relative 'view'

module Simpler
  class Controller
    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      set_default_headers
      params[:id] = set_request_param
      send(action)
      write_response

      @response.finish
    end

    private

    def set_request_param
      @request.env['REQUEST_PATH'].split('/')[2]
    end

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def status(value)
      @response.status = value
    end

    def headers
      @response
    end

    def write_response
      body = render_plain || render_body

      @response.write(body)
    end

    def render_plain
      return unless @request.env['simpler.template'].is_a?(Hash)

      @response['Content-Type'] = 'text/plain'
      @request.env['simpler.template'][:plain]
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def params
      @request.params
    end

    def render(template)
      @request.env['simpler.template'] = template
    end
  end
end
