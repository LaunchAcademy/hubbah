require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
  c.default_cassette_options = { :record => :new_episodes }
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<HUBBAH_API_KEY>') { ENV['HUBBAH_API_KEY'] }
  c.filter_sensitive_data('<HUBBAH_HUB_ID>') { ENV['HUBBAH_HUB_ID'] }
  c.filter_sensitive_data('<HUBBAH_FORM_GUID>') { ENV['HUBBAH_FORM_GUID'] }
end
