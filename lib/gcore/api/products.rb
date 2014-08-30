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
          :timeout => -1, 
          :open_timeout => -1, 
          :authorization => Gcore::Api.authorization))          
      end
      
      def self.list(params)        
        JSON.parse(RestClient.get("#{Gcore::Api.endpoint}/products", 
          :params => params, 
          :content_type => :json, 
          :accept => :json, 
          :timeout => -1, 
          :open_timeout => -1, 
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
            :timeout => -1, 
            :open_timeout => -1, 
            :authorization => Gcore::Api.authorization))
            
           break if products.length == 0
           
           return_value.concat(products)
           params[:page] += 1
        }
        
        return return_value   
      
      end      
      
      def self.create(params, attempts=1)
        endpoint = "#{Gcore::Api.endpoint}/products?store_id=#{params[:store_id]}"
        body = params[:body].to_json
        
        begin          
          return {} if params.nil? || params.empty?
 
          JSON.parse(RestClient.post(endpoint, 
            body, 
            :content_type => :json, 
            :accept => :json, 
            :timeout => -1, 
            :open_timeout => -1, 
            :authorization => Gcore::Api.authorization))     
        rescue StandardError => ex
          if attempts <= 10
            $stderr.puts "Gcore::Api::Products.create() failed - #{ex.message}. Trying again..."
            $stderr.puts "Method: POST"
            $stderr.puts "Endpoint: #{endpoint}"
            $stderr.puts "Body: #{body}" 
            self.create(params, attempts + 1)
          else
            $stderr.puts "Gcore::Api::Products.create() failed - #{ex.message}. Cannot recover."
            return {}
          end
        end
      end
      
      
      def self.update(params, attempts=1)
      
        return self.mass_update(params) if params.is_a?(Array)
        
        #Clone params as not to unintentionally modify it
        local_params = params.clone
        
        id = local_params[:id]
        local_params.delete(:id)
        
        endpoint = "#{Gcore::Api.endpoint}/products/#{id}"
        body = local_params.to_json
        begin
          JSON.parse(RestClient.put(endpoint, 
            body, 
            :content_type => :json, 
            :accept => :json, 
            :timeout => -1, 
             :open_timeout => -1,
            :authorization => Gcore::Api.authorization))
        rescue StandardError => ex
           if attempts <= 10
            $stderr.puts "Gcore::Api::Products.update() failed - #{ex.message}. Trying again..."
            $stderr.puts "Method: PUT"
            $stderr.puts "Endpoint: #{endpoint}"
            $stderr.puts "Body: #{body}" 
            self.update(params, attempts + 1)
          else
            $stderr.puts "Gcore::Api::Products.update() failed - #{ex.message}. Cannot recover."
            return {}
          end
        end                      
      end
      
      def self.mass_update(params, attempts=1)
        
        endpoint = "#{Gcore::Api.endpoint}/products"
        body = ""
        
        begin
          slice_count = 100
          
          params_array = params.each_slice(slice_count).to_a
          return_value = []
  
          params_array.each_with_index do |params_slice, index|
            $stderr.puts "Mass update - page #{index}"
            #$stderr.puts "JSON:" + params_slice.to_json
            body = params_slice.to_json
            return_value.concat(JSON.parse(RestClient.put(endpoint, 
              body, 
              :content_type => :json, 
              :accept => :json, 
              :timeout => -1, 
              :open_timeout => -1,
              :authorization => Gcore::Api.authorization)))           
          end          
          return_value
          
        rescue StandardError => ex
           if attempts <= 10
            $stderr.puts "Gcore::Api::Products.mass_update() failed - #{ex.message}. Trying again..."
            $stderr.puts "Method: PUT"
            $stderr.puts "Endpoint: #{endpoint}"
            $stderr.puts "Body: #{body}" 
            self.mass_update(params, attempts + 1)
          else
            $stderr.puts "Gcore::Api::Products.mass_update() failed - #{ex.message}. Cannot recover."
            return {}
          end
        end     
      end
            
      def self.delete(params)
        id = params[:id]
        params.delete(:id)
      
        JSON.parse(RestClient.delete("#{Gcore::Api.endpoint}/products/#{id}", 
          :content_type => :json, 
          :accept => :json, 
          :timeout => -1, 
           :open_timeout => -1,
          :authorization => Gcore::Api.authorization))          
      end
      
    end
  end
end