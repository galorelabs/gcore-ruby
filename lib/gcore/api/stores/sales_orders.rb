require 'json'
require 'rest-client'
require 'base64'
require 'gcore/api/exceptions'

module Gcore
  class Api
    class Stores
      class SalesOrders
        
        #Display single sales order
        def self.show(params = {})
           store_code = params[:store_id] || params[:store_code]
           order_number = params[:order_number]
           url = "#{Gcore::Api.endpoint}/stores/#{store_code}/sales_orders/#{order_number}"
           begin
            return JSON.parse(RestClient.get(url, Gcore::Api.header),  {symbolize_names: true})
           rescue RestClient::ResourceNotFound
             raise Gcore::Api::Exceptions::SalesOrderNotFoundException.new(store_code: store_code, order_number: order_number )
           end           
        end
        
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
        
        def self.pull(params = {})
          store_code = params[:store_id] || params[:store_code]
          order_number = params[:order_number]
          entity_id = params[:entity_id]
          
          url = "#{Gcore::Api.endpoint}/stores/#{store_code}/sales_orders/#{order_number}/pull"
          JSON.parse(RestClient.post(url, {entity_id: entity_id}.to_json, Gcore::Api.header), {symbolize_names: true})  
        end
        
        
        
      end
    end
  end
end
