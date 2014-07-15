require 'gcore/api'
require 'gcore/api/sales_orders'

Gcore::Api.setup do |setup|
  
  if !ENV['API_KEY']
    $stderr.print "Please enter api key:"
    setup[:api_key]  = gets.chomp
  else
    setup[:api_key] = ENV['API_KEY'] 
  end
  
  if !ENV['API_SECRET']
    $stderr.print "Please enter api password:"
    setup[:api_secret]  = gets.chomp
  else
    setup[:api_secret] = ENV['API_SECRET']
  end
  
  setup[:endpoint]      = "http://qa.api.gcore.galoretv.com"
end

$stderr.puts "\nGetting Sales Orders of all store fronts (page 1)"
sales_orders = Gcore::Api::SalesOrders.list
$stderr.puts "#{sales_orders.first['order_number']}(#{sales_orders.first['store_id']})...#{sales_orders.last['order_number']}(#{sales_orders.last['store_id']})" 
$stderr.puts "#{sales_orders.length} sales orders"

$stderr.puts "\nGetting Sales Orders of all store fronts (page 2)"
sales_orders = Gcore::Api::SalesOrders.list(page:2)
$stderr.puts "#{sales_orders.first['order_number']}(#{sales_orders.first['store_id']})...#{sales_orders.last['order_number']}(#{sales_orders.last['store_id']})" 
$stderr.puts "#{sales_orders.length} sales orders"

$stderr.puts "\nGetting Sales Orders of Plains & Prints (page 1)"
sales_orders = Gcore::Api::SalesOrders.list(store_id: :plainsandprints)
$stderr.puts "#{sales_orders.first['order_number']}(#{sales_orders.first['store_id']})...#{sales_orders.last['order_number']}(#{sales_orders.last['store_id']})" 
$stderr.puts "#{sales_orders.length} sales orders"

$stderr.puts "\nGetting Sales Orders of Plains & Prints (page 2)"
sales_orders = Gcore::Api::SalesOrders.list(store_id: :plainsandprints, page:2)
$stderr.puts "#{sales_orders.first['order_number']}(#{sales_orders.first['store_id']})...#{sales_orders.last['order_number']}(#{sales_orders.last['store_id']})" 
$stderr.puts "#{sales_orders.length} sales orders"

$stderr.puts "\nGetting all Sales Orders for Gourdo's"
sales_orders = []
page = 1
loop do
  list = Gcore::Api::SalesOrders.list(store_id: :gourdos, page: page)
  break if list.length == 0
  $stderr.puts "#{list.first['order_number']}(#{list.first['store_id']})...#{list.last['order_number']}(#{list.last['store_id']})" 
  sales_orders = sales_orders.concat(list)
  page = page + 1
end
$stderr.puts "#{sales_orders.length} sales orders"

