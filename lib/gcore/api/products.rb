require 'rest_client'
require 'json'

module Gcore
  class Api
    class Products
    
      def self.show(params)
      
        id = params[:id]
        params.delete(:id)
      
        JSON.parse(RestClient.get("#{Gcore::Api.endpoint}/products/#{id}", 
          :params => params, 
          :content_type => :json, 
          :accept => :json, 
          :timeout => nil, 
          :authorization => Gcore::Api.authorization))          
      end
      
      def self.list(params)        
        JSON.parse(RestClient.get("#{Gcore::Api.endpoint}/products", 
          :params => params, 
          :content_type => :json, 
          :accept => :json, 
          :timeout => nil, 
          :authorization => Gcore::Api.authorization))            
      end
      
      def self.create(params)
        JSON.parse(RestClient.post("#{Gcore::Api.endpoint}/products", 
          params.to_json, 
          :content_type => :json, 
          :accept => :json, 
          :timeout => nil, 
          :authorization => Gcore::Api.authorization))    
      end
      
      
      def self.update(params)
      
        id = params[:id]
        params.delete(:id)
      
        JSON.parse(RestClient.put("#{Gcore::Api.endpoint}/products/#{id}", 
          params.to_json, 
          :content_type => :json, 
          :accept => :json, 
          :timeout => nil, 
          :authorization => Gcore::Api.authorization))        
      end
            
      def self.delete(params)
        id = params[:id]
        params.delete(:id)
      
        JSON.parse(RestClient.delete("#{Gcore::Api.endpoint}/products/#{id}", 
          :content_type => :json, 
          :accept => :json, 
          :timeout => nil, 
          :authorization => Gcore::Api.authorization))          
      end
      
    end
  end
end