# GCore Ruby

The GCore Ruby gem is a convenience wrapper for the GCore REST API.

## Installation

Add this line to your application's Gemfile:

    gem 'gcore-ruby'

And then execute:

    $ bundle install

Or install it yourself as:

    $ rake install

## Configuring

GCore Ruby may be configured in two ways, in order of priority (high to low). That is, if GCore is configured with both Setup Block and YAML, the Setup Block overrides the YAML configuration.

### Setup Block
    require 'gcore/api'
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


## Usage
    require 'gcore/api'

    #Get latest 25 orders of Store with store code 'cudsly'
    require 'gcore/api/sales_orders'
    sales_orders = Gcore::Api::SalesOrders.list(store_id: 'cudsly')
    
    #Get next 25 orders
    sales_orders = Gcore::Api::SalesOrders.list(store_id: 'cudsly', page: 2)
    
    #Get first 25 products of Cudsly
    require 'gcore/api/products'    
    products = Gcore::Api::Products.list(store_id: 'cudsly')

## Contributing

1. Fork it ( https://github.com/[my-github-username]/gcore-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
