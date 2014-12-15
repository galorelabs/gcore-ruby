require 'json'
require 'rest-client'

module Gcore
  class Api
    class Stores
      class SalesOrders
        def self.list(params = {})
          store_code = params[:store_id] || params[:store_code]
          allowed_params = [:limit, :page]
          url_params = params.select{|key, value| allowed_params.include? key} || {}           
          url = "#{Gcore::Api.endpoint}/stores/#{store_code}/sales_orders"
          JSON.parse(RestClient.get(url, Gcore::Api.header.merge(params: url_params)))                
        end
      end
    end
  end
end
