require 'gcore/api'
require 'gcore/api/products'

Gcore::Api.setup do |setup|
  setup[:api_key]       = "DEV_API_KEY"
  setup[:api_secret]    = "DEV_API_SECRET"
  setup[:endpoint]      = "http://qa.api.gcore.galoretv.com"
end


$stderr.puts "\nGetting Products..."
products =  Gcore::Api::Products.list(store_id: :plainsandprints)
$stderr.puts "id:#{products[0]['_id']['$oid']}  SKU:#{products[0]['sku']}  Name:#{products[0]['name']}"
products =  Gcore::Api::Products.list(store_id: :plainsandprints, page: 2)
$stderr.puts "id:#{products[0]['_id']['$oid']}  SKU:#{products[0]['sku']}  Name:#{products[0]['name']}"

$stderr.puts "\nGetting Single Product..."
product =  Gcore::Api::Products.show(id: "539ebf43696e645f45000000")
$stderr.puts "id:#{product['_id']['$oid']}  SKU:#{product['sku']}  Name:#{product['name']}"
$stderr.puts "Quantity: #{product['quantity']}"

$stderr.puts "\nUpdating Product..."
product =  Gcore::Api::Products.update(id: "539ebf43696e645f45000000", quantity: 69)
$stderr.puts "id:#{product['_id']['$oid']}  SKU:#{product['sku']}  Name:#{product['name']}"
$stderr.puts "Quantity: #{product['quantity']}"


$stderr.puts "\nCreating Product..."
new_product =  Gcore::Api::Products.create(store_id: :plainsandprints, sku: "APPRASDYPOGI", name: "Rasdy Pogi XL", quantity: 169)
$stderr.puts "id:#{new_product['_id']['$oid']}  SKU:#{new_product['sku']}  Name:#{new_product['name']}"
$stderr.puts "Quantity: #{new_product['quantity']}"

$stderr.puts "\nDeleting Product..."
new_product =  Gcore::Api::Products.delete(id: new_product['_id']['$oid'])
$stderr.puts "id:#{new_product['_id']['$oid']}  SKU:#{new_product['sku']}  Name:#{new_product['name']}"
$stderr.puts "Quantity: #{new_product['quantity']}"