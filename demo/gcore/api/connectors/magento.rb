require 'gcore/api'
require 'gcore/api/connectors/magento'

Gcore::Api.setup do |setup|
  setup[:api_key]       = "DEV_API_KEY"
  setup[:api_secret]    = "DEV_API_SECRET"
  setup[:endpoint]      = "http://qa.api.gcore.galoretv.com"
end

$stderr.puts Gcore::Api::Connectors::Magento.api_get(api: 'products', store: 'plainsandprints', page: 2)
