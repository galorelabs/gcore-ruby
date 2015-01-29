require 'rest_client'
require 'json'

module Gcore
  class Api
    module Systems
      module Syncs
        class Inventory

          def self.create(params, attempts=1)
            endpoint = "#{Gcore::Api.endpoint}/systems/syncs/inventory?store_id=#{params[:store_id]}"
            body = params[:body].to_json

            begin
              return {} if params.nil? || params.empty?

              JSON.parse(RestClient.post(endpoint,
               body,
               :content_type => :json,
               :accept => :json,
               :timeout => -1,
               :open_timeout => -1,
               :authorization => Gcore::Api.authorization), {symbolize_names: true})

            rescue StandardError => ex
              if attempts <= 10
                $stderr.puts "Gcore::Api::Systems::Syncs:Inventory.create() failed - #{ex.message}. Trying again..."
                $stderr.puts "Method: POST"
                $stderr.puts "Endpoint: #{endpoint}"
                $stderr.puts "Body: #{body}"
                self.create(params, attempts + 1)
              else
                $stderr.puts "Gcore::Api::Systems::Syncs:Inventory.create() failed - #{ex.message}. Cannot recover."
                return {}
              end
            end

          end
        end
      end
    end
  end
end