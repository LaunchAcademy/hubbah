require 'spec_helper'

describe Hubbah::Payload, vcr: true do
  include Hubbah::RackHelper

  let(:configuration) { Hubbah.configuration }
  let(:url) { 'http://localhost/' }
  let(:env) {  env_for(url) }
  let(:payload) { Hubbah::Payload.new(configuration, env) }

  it 'does not include nil values in the context' do
    expect(payload.hs_context).to_not have_key('hutk')
  end

  it 'includes the ip address when present' do
    ip = '127.0.0.1'
    env['REMOTE_ADDR'] = ip
    expect(payload.hs_context['ipAddress']).to eq(ip)
  end

  it 'includes the request url when present' do
    expect(payload.hs_context['pageUrl']).to eq(url)
  end

  it 'favors the referrer when present for the pageUrl' do
    referrer = 'http://referrer/me'
    env['HTTP_REFERER'] = referrer
    expect(payload.hs_context['pageUrl']).to eq(referrer)
  end

  it 'includes the hutk cookie when present' do
    cookie_val = 'r3142423154dfadgfdty'
    env['HTTP_COOKIE'] = "hubspotutk=#{cookie_val}"
    expect(payload.hs_context['hutk']).to eq(cookie_val)
  end

  it 'submits successfully to hubspot' do
    cookie_val = 'r3142423154dfadgfdty'
    env['HTTP_COOKIE'] = "hubspotutk=#{cookie_val}"

    referrer = 'http://referrer/me'
    env['HTTP_REFERER'] = referrer

    ip = '127.0.0.1'
    env['REMOTE_ADDR'] = ip

    expect(payload.submit(form_guid, 'Email' => 'user@example.com')).to be_true
  end

  protected
  def form_guid
    ENV['HUBBAH_FORM_GUID']
  end
end
