# Hubbah

```ruby
#in an initializer
config.middleware.use Hubba::Middleware do |app|
  app.hub_id = '312425'
end

#in your controller, when you want to submit the form payload:
env['hubbah'].submit(form_guid, params[:subscriber])
```

TODO: Write a gem description

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
