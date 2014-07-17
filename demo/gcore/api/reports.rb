require 'gcore/api'
require 'gcore/api/reports'
require 'date'

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


$stderr.puts "\nClearing up Sample Report for Plains & Prints"
report = Gcore::Api::Reports.destroy(store: :plainsandprints, report_name: :sample_report)
$stderr.puts "#{report['count']} items deleted."

begin
  $stderr.puts "\nGetting Sample Report for Plains & Prints"
  report = Gcore::Api::Reports.show(store: :plainsandprints, report_name: :sample_report)
  $stderr.puts report.to_json
rescue StandardError => ex
  $stderr.puts ex.message
end

$stderr.puts "\nCreating Sample Report for Plains & Prints"
Gcore::Api::Reports.create(store: :plainsandprints, report_name: :sample_report, key: "2014-07-17", value: {sum: 200.50}, date: Date.parse("2014-07-17"))
Gcore::Api::Reports.create(store: :plainsandprints, report_name: :sample_report, key: "2014-07-15", value: {sum: 300.25}, date: Date.parse("2014-07-15"))

$stderr.puts "\nGetting Sample Report for Plains & Prints"
report = Gcore::Api::Reports.show(store: :plainsandprints, report_name: :sample_report)
$stderr.puts report.to_json
