module Hubbah
  class Payload

    def initialize(configuration, env)
      @configuration = configuration
      request = Rack::Request.new(env)
      @hutk = request.cookies['hubspotutk']
      @ip = request.ip
      @url = request.url
      if !request.referer.nil? && request.referer != '/'
        @url = request.referer
      end
    end

    def submit(guid, attributes)
      decorated_attrs = attributes.dup
      decorated_attrs['hs_context'] = hs_context.to_json
      submission = Hubbah::FormSubmission.new(guid, decorated_attrs, @configuration)
      submission.submit
    end

    def hs_context
      context_map.inject({}) do |map, keypair|
        unless keypair[1].nil?
          map[keypair[0]] = keypair[1]
        end
        map
      end
    end

    protected
    def context_map
      {
        'hutk' => @hutk,
        'ipAddress' => @ip,
        'pageUrl' => @url
      }
    end

  end
end
