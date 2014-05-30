require 'spec_helper'

describe Hubbah::Contact, vcr: true do
  let(:email) { 'user@example.com' }
  it 'updates a relevant contact' do
    contact = Hubbah::Contact.create_or_update(email, {
      'firstname' => 'user'
    })
    expect(contact.vid).to_not be_nil
  end

  it 'raises an error when I encounter a 500' do
    contact = Hubbah::Contact.new({
      'email' => email,
      'firstname' => 'user'
    })

    stub_response(contact, [500, {}, 'something bad happened'])
    expect(lambda { contact.save }).to raise_error(Hubbah::ServerErrorEncountered)
    expect(contact.vid).to be_nil
  end

  it 'raises an error when I encounter a 401' do
    contact = Hubbah::Contact.new({
      'email' => email,
      'firstname' => 'user'
    })

    stub_response(contact, [401, {}, 'something bad happened'])
    expect(lambda { contact.save }).to raise_error(Hubbah::AccessDenied)
    expect(contact.vid).to be_nil
  end

  protected
  def stub_response(contact, response)
    path = "/contacts/v1/contact/createOrUpdate/email/#{URI.encode(contact.email)}/"
    mock_client = Faraday.new do |builder|
      builder.adapter :test do |stubs|
        stubs.post(path) { response }
      end
    end

    contact.stubs(:client).returns(mock_client)
  end
end
