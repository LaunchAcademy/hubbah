require 'spec_helper'

describe Hubbah::FormSubmission, vcr: true do
  let(:submission) do
    Hubbah::FormSubmission.new(form_guid, {
      'Email' => 'user@example.com'
    })
  end

  it 'submits a form with required data successfully' do
    expect(submission.submit).to be_true
  end

  it 'raises an exception when a 404 is encountered' do
    stub_response(submission, [404, {}, nil])

    expect(lambda{ submission.submit }).to raise_error(Hubbah::HubIdNotConfigured)
  end

  it 'raises an exception when a 500 is encountered' do
    stub_response(submission, [500, {}, nil])

    expect(lambda{ submission.submit }).to raise_error(Hubbah::ServerErrorEncountered)
  end

  protected
  def stub_response(submission, response)
    mock_client = Faraday.new do |builder|
      builder.adapter :test do |stubs|
        stubs.post("/uploads/form/v2/#{hub_id}/#{form_guid}", '' ) { response }
      end
    end

    submission.stubs(:client).returns(mock_client)
  end

  def form_guid
    ENV['HUBBAH_FORM_GUID']
  end

  def hub_id
    Hubbah.hub_id
  end
end
