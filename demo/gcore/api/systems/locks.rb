require 'gcore/api'
require 'gcore/api/systems/locks'
require 'active_support'
require 'active_support/core_ext/numeric/time'

Gcore::Api.setup do |setup|
  setup[:api_key]       = "DEV_API_KEY"
  setup[:api_secret]    = "DEV_API_SECRET"
  setup[:endpoint]      = "http://qa.api.gcore.galoretv.com"
end

$stderr.puts Gcore::Api::Systems::Locks.create(name: "sales_orders_sync_magento_gcore_plainsandprints")
$stderr.puts Gcore::Api::Systems::Locks.create(name: "sales_orders_sync_magento_gcore_plainsandprints")
$stderr.puts Gcore::Api::Systems::Locks.create(name: "sales_orders_sync_magento_gcore_plainsandprints_2", expires_at: 5.hours.from_now)
$stderr.puts Gcore::Api::Systems::Locks.delete(name: "sales_orders_sync_magento_gcore_plainsandprints")