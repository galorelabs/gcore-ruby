# GCore Ruby

The GCore Ruby gem is a convenience wrapper for the GCore REST API.

## Installation

Add this line to your application's Gemfile:

    gem 'gcore-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gcore-ruby

## Usage

TODO: Write usage instructions here

## Configuring

GCore Ruby may be configured in two ways, in order of priority (high to low). That is, if GCore is configured with both Setup Block and YAML, the Setup Block overrides the YAML configuration.

### Setup Block

    Gcore::Api.setup do |setup|
        setup[:api_key] = "YOUR_API_KEY_HERE"
        setup[:api_secret] = "YOUR_API_SECRET_HERE"
        setup[:endpoint] = "https://api.gcore.galoretv.com"
    end
    
### YAML

If `~/.gcore/gcore.yaml` exists, it will load this file.

    #~/.gcore/gcore.yaml
    api_key: "YOUR_API_KEY_HERE"
    api_secret: "YOUR_API_SECRET_HERE"
    endpoint: "https://api.gcore.galoretv.com"


## Contributing

1. Fork it ( https://github.com/[my-github-username]/gcore-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
