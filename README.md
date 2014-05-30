# Hubbah

Hubbah makes it easy to submit hubspot form data.

```ruby
#in an initializer
config.middleware.use Hubba::Middleware do |app|
  app.hub_id = 'xxxxxx'
end

#in your controller, when you want to submit the form payload:
env['hubbah'].submit(form_guid, params[:subscriber])
```

Hubbah will send the relevant `hs_context` metadata (ip address, tracking cookie, and referrer) along with the data you pass to the `submit` invocation. The `form_guid` should correlate with the form you've configured in hubspot.

## Installation

Add this line to your application's Gemfile:

    gem 'hubbah'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hubbah

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/hubbah/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
