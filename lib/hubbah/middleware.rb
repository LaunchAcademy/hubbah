require 'uri'
require 'json'
require 'rack'

module Hubbah
  class Middleware < Rack::Builder
    def initialize(app, &block)
      @app = app
      @configuration = Hubbah::Configuration.new(&block)
      super {}
    end

    def call(env)
      env['hubbah'] = Hubbah::Payload.new(@configuration, env)
      to_app.call(env)
    end

    protected
    def encode(str)
      URI.encode(str || '')
    end
  end
end
