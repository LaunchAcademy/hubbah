module Hubbah
  class Configuration
    attr_accessor :api_key, :hub_id

    def initialize(&block)
      block.call(self)
    end
  end
end
