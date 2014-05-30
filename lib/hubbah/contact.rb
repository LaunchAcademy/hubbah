require 'uri'
require 'json'

module Hubbah
  class Contact < Hubbah::Model
    attr_reader :attributes, :vid

    def initialize(attributes)
      @attributes = attributes
    end

    def email
      attributes['email']
    end

    def save
      resp = client.post do |req|
        req.url "/contacts/v1/contact/createOrUpdate/email/#{URI.encode(email)}/"
        req.body = { properties: property_collection }.to_json
        req.headers[:content_type] = 'application/json'
      end

      if resp.status  == 200
        @vid = JSON.parse(resp.body)['vid']
        return true
      elsif resp.status == 401
        raise Hubbah::AccessDenied.new(resp.body)
      elsif resp.status == 500
        raise Hubbah::ServerErrorEncountered.new(resp.body)
      else
        raise Hubbah::Error.new(resp.body)
      end
    end

    def property_collection
      @attributes.map do |field, value|
        {
          property: field,
          value: value
        }
      end
    end

    class << self
      def create_or_update(email, attributes)
        new(attributes.merge('email' => email)).tap do |contact|
          contact.save
        end
      end
    end

    protected
    def client
      @client ||= Faraday.new({
        url: 'http://api.hubapi.com/',
        params: {
          hapikey: api_key,
          portalId: hub_id
        }
      })
    end

    def hub_id
      configuration.hub_id
    end

    def api_key
      configuration.api_key
    end

    def configuration
      Hubbah.configuration
    end
  end
end
