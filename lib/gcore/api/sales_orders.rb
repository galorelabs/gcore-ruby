require 'rest_client'
require 'json'

module Gcore
  class Api
    class SalesOrders
    
      def self.show(params)
      
        # id = params[:id]
        # params.delete(:id)
#       
        # JSON.parse(RestClient.get("#{Gcore::Api.endpoint}/products/#{id}", 
          # :params => params, 
          # :content_type => :json, 
          # :accept => :json, 
          # :timeout => -1, 
          # :open_timeout => -1, 
          # :authorization => Gcore::Api.authorization))          
      end
      
      def self.list(params = {})
        
         params[:limit] = params[:limit] || Gcore::Api::LIST_LIMIT
         params[:page] = params[:page] || 1
                 
         JSON.parse(RestClient.get("#{Gcore::Api.endpoint}/sales_orders", 
           :params => params, 
           :content_type => :json, 
           :accept => :json, 
           :timeout => -1, 
           :open_timeout => -1, 
           :authorization => Gcore::Api.authorization))            
      end
      
      
      def self.create(params, attempts=1)
        begin
          
          return {} if params.nil? || params.empty?
          
          url = "#{Gcore::Api.endpoint}/sales_orders?store_id=#{params[:store_id]}"
          
          JSON.parse(RestClient.post(url, 
            params[:body].to_json, 
            :content_type => :json, 
            :accept => :json, 
            :timeout => -1, 
            :open_timeout => -1, 
            :authorization => Gcore::Api.authorization))     
        rescue StandardError => ex
          if attempts <= 10
            $stderr.puts "Gcore::Api::Products.create() failed - #{ex.message}. Trying again..." 
            self.create(params, attempts + 1)
          else
            $stderr.puts "Gcore::Api::Products.create() failed - #{ex.message}. Cannot recover."
            return {}
          end
        end
      end
      
      
      def self.update(params)
      
        # return self.mass_update(params) if params.is_a?(Array)
#       
        # id = params[:id]
        # params.delete(:id)
#       
        # JSON.parse(RestClient.put("#{Gcore::Api.endpoint}/products/#{id}", 
          # params.to_json, 
          # :content_type => :json, 
          # :accept => :json, 
          # :timeout => -1, 
           # :open_timeout => -1,
          # :authorization => Gcore::Api.authorization))        
      end
      
      def self.mass_update(params)
        
        # slice_count = 100
#         
        # params_array = params.each_slice(slice_count).to_a
        # return_value = []
# 
        # params_array.each_with_index do |params_slice, index|
          # $stderr.puts "Mass update - page #{index}"
          # #$stderr.puts "JSON:" + params_slice.to_json
          # return_value.concat(JSON.parse(RestClient.put("#{Gcore::Api.endpoint}/products", 
            # params_slice.to_json, 
            # :content_type => :json, 
            # :accept => :json, 
            # :timeout => -1, 
            # :open_timeout => -1,
            # :authorization => Gcore::Api.authorization)))           
#             
#             
#                             
        # end        

        # return_value
      
      end
            
      def self.delete(params)
        # id = params[:id]
        # params.delete(:id)
#       
        # JSON.parse(RestClient.delete("#{Gcore::Api.endpoint}/products/#{id}", 
          # :content_type => :json, 
          # :accept => :json, 
          # :timeout => -1, 
           # :open_timeout => -1,
          # :authorization => Gcore::Api.authorization))          
      end
      
    end
  end
end