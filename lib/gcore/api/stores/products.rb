require 'json'
require 'rest-client'
require 'base64'
require 'gcore/api/exceptions'

module Gcore
  class Api
    class Stores
      class Products
        
        #Display single sales order
        def self.show(params = {})
           store_code = params[:store_id] || params[:store_code]
           sku = params[:sku]
           url = "#{Gcore::Api.endpoint}/stores/#{store_code}/products/#{sku}"
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
          url = "#{Gcore::Api.endpoint}/stores/#{store_code}/products"
          JSON.parse(RestClient.get(url, Gcore::Api.header.merge(params: url_params)), {symbolize_names: true})                
        end
        
      end
    end
  end
end
