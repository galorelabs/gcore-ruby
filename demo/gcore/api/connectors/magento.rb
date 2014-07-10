require 'gcore/api'
require 'gcore/api/connectors/magento'

Gcore::Api.setup do |setup|
  $stderr.print "Please enter api key:"
  setup[:api_key]  = gets.chomp
  
  $stderr.print "Please enter api password:"
  setup[:api_secret]  = gets.chomp
  
  setup[:endpoint]      = "http://qa.api.gcore.galoretv.com"
end

$stderr.puts Gcore::Api::Connectors::Magento.api_get(api: 'products', store: 'plainsandprints', page: 2)
