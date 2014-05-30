require 'hubbah/version'
require 'hubbah/configuration'
require 'hubbah/model'
require 'hubbah/form_submission'
require 'hubbah/contact'

require 'hubbah/middleware'
require 'hubbah/payload'

module Hubbah
  class << self
    attr_accessor :configuration

    def configure(&block)
      @configuration = Configuration.new(&block)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def hub_id
      configuration.nil? ? nil : configuration.hub_id
    end

    def api_key
      configuration.nil? ? nil : configuration.api_key
    end
  end

  class Error < Exception; end
  class HubIdNotConfigured < Error; end
  class ServerErrorEncountered < Error; end
  class AccessDenied < Error; end
end
