require 'spec_helper'

describe Hubbah::Configuration do
  it 'assigns an api key' do
    key = 'blah'
    config = Hubbah::Configuration.new do |c|
      c.api_key = key
    end
    expect(config.api_key).to eq(key)
  end

  it 'assigns a hub_id' do
    hub_id = '342'
    config = Hubbah::Configuration.new do |c|
      c.hub_id = hub_id
    end

    expect(config.hub_id).to eq(hub_id)
  end
end
