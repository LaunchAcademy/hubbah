require 'faraday'

module Hubbah
  class FormSubmission
    def initialize(form_guid, attributes = {})
      @form_guid = form_guid
      @attributes= attributes
    end

    def submit
      resp = client.post("/uploads/form/v2/#{hub_id}/#{@form_guid}", @attributes)
      if resp.status == 404
        raise Hubbah::HubIdNotConfigured
      elsif resp.status == 500
        raise Hubbah::ServerErrorEncountered
      else
        return true
      end
    end

    protected
    def client
      @client ||= Faraday.new({
        url: 'https://forms.hubspot.com'
      })
    end

    def hub_id
      Hubbah.hub_id
    end
  end
end
