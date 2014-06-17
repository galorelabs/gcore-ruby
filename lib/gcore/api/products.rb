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
      
      def self.list_all(params)
      
        return_value = []
        params[:page] = 1
        
        loop {      
          products = JSON.parse(RestClient.get("#{Gcore::Api.endpoint}/products", 
            :params => params, 
            :content_type => :json, 
            :accept => :json, 
            :timeout => nil, 
            :authorization => Gcore::Api.authorization))
            
           break if products.length == 0
           
           return_value.concat(products)
           params[:page] += 1
        }
        
        return return_value   
      
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
      
        return self.mass_update(params) if params.is_a?(Array)
      
        id = params[:id]
        params.delete(:id)
      
        JSON.parse(RestClient.put("#{Gcore::Api.endpoint}/products/#{id}", 
          params.to_json, 
          :content_type => :json, 
          :accept => :json, 
          :timeout => nil, 
          :authorization => Gcore::Api.authorization))        
      end
      
      def self.mass_update(params)

        JSON.parse(RestClient.put("#{Gcore::Api.endpoint}/products", 
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