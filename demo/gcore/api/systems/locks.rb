require 'gcore/api'
require 'gcore/api/systems/locks'
require 'active_support'
require 'active_support/core_ext/numeric/time'

Gcore::Api.setup do |setup|
  $stderr.print "Please enter api key:"
  setup[:api_key]  = gets.chomp
  
  $stderr.print "Please enter api password:"
  setup[:api_secret]  = gets.chomp
  
  setup[:endpoint]      = "http://qa.api.gcore.galoretv.com"
end

$stderr.puts Gcore::Api::Systems::Locks.create(name: "sales_orders_sync_magento_gcore_plainsandprints")
$stderr.puts Gcore::Api::Systems::Locks.create(name: "sales_orders_sync_magento_gcore_plainsandprints")
$stderr.puts Gcore::Api::Systems::Locks.create(name: "sales_orders_sync_magento_gcore_plainsandprints_2", expires_at: 5.hours.from_now)
$stderr.puts Gcore::Api::Systems::Locks.delete(name: "sales_orders_sync_magento_gcore_plainsandprints")

#First time should succeed.
lock = Gcore::Api::Systems::Locks.create(name: "sales_orders_sync_magento_gcore_plainsandprints")
if lock["lock_obtained"] === true
  $stderr.puts "Lock successfully obtained."
else
  $stderr.puts "Cannot proceed - sync is locked. Exiting..."
end

#Second time should fail.
lock = Gcore::Api::Systems::Locks.create(name: "sales_orders_sync_magento_gcore_plainsandprints")
if lock["lock_obtained"] === true
  $stderr.puts "Lock successfully obtained."
else
  $stderr.puts "Cannot proceed - sync is locked. Exiting..."
end

