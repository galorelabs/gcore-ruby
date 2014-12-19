require 'json'
require 'rest-client'
require 'base64'

module Gcore
  class Api
    class Stores
      class SalesOrders
        
        def self.list(params = {})
          store_code = params[:store_id] || params[:store_code]
          allowed_params = [:limit, :page]
          url_params = params.select{|key, value| allowed_params.include? key} || {}           
          url = "#{Gcore::Api.endpoint}/stores/#{store_code}/sales_orders"
          JSON.parse(RestClient.get(url, Gcore::Api.header.merge(params: url_params)), {symbolize_names: true})                
        end
        
        def self.sku_count(params = {})
          store_code = params[:store_id] || params[:store_code]
          
          #Allow web unsafe SKU's
          sku = Base64.urlsafe_encode64(params[:sku])
          
          url = "#{Gcore::Api.endpoint}/stores/#{store_code}/sales_orders/sku_count/#{sku}"
          JSON.parse(RestClient.get(url, Gcore::Api.header.merge(params: {is_base64: "true"})), {symbolize_names: true})  
        end
        
      end
    end
  end
end
