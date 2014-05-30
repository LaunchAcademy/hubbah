require 'spec_helper'

describe Hubbah::Middleware do
  include Hubbah::RackHelper

  let :middleware do
    Hubbah::Middleware.new(app) do |a|
      a.hub_id = '312425'
    end
  end

  it 'sets the hubbah env variable' do
    app, env = middleware.call(env_for("http://localhost/"))
    env['hubbah'].should_not be_nil
    env['hubbah'].should be_kind_of(Hubbah::Payload)
  end
end
