require 'rack/test'

module Hubbah
  module RackHelper
    include Rack::Test::Methods

    def self.included(base)
      base.let(:app) { ->(env) { [200, env, "app"] } }
    end

    protected
    def env_for url, opts={}
      ::Rack::MockRequest.env_for(url, opts)
    end
  end
end
