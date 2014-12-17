require 'json'
require 'rest-client'

module Gcore
  class Api
    class Connectors
      class Magento
        def self.api_get(params, attempts = 1)
          begin
            params[:limit] = params[:limit]   || 25
            params[:page] = params[:page]     || 1
            
            store = params[:store]         
            api   = params[:api].to_s
            
            params.delete(:store)
            params.delete(:api)
            
            JSON.parse(RestClient.get("#{Gcore::Api.endpoint}/connectors/magento/#{store}/#{api}", 
              :params => params, 
              :content_type => :json, 
              :accept => :json, 
              :timeout => -1, 
              :open_timeout => -1,  
              :authorization => Gcore::Api.authorization), {symbolize_names: true})[:model]
              
          rescue StandardError => ex
            if attempts <= 10
              $stderr.puts "Gcore::Api::Connectors::Magento.api_get() failed - #{ex.message}. Trying again..." 
              self.api_get(params, attempts + 1)
            else
              $stderr.puts "Gcore::Api::Connectors::Magento.api_get() Failed - #{ex.message}.. Cannot recover."
              return [{0 => nil}]
            end           
          end             
        end
        
        def self.api_post()
          
        end
        
        def self.api_put(params, attempts = 1)
          begin
            
            store = params[:store]         
            api   = params[:api]
            
            #params.delete(:store)
            #params.delete(:api)
            
            JSON.parse(RestClient.put("#{Gcore::Api.endpoint}/connectors/magento/#{store}/#{api}", 
              params[:body], 
              :content_type => :json, 
              :accept => :json, 
              :timeout => -1, 
              :open_timeout => -1,  
              :authorization => Gcore::Api.authorization), {symbolize_names: true})[:model]
              
          rescue StandardError => ex
            if attempts <= 10
              $stderr.puts "Gcore::Api::Connectors::Magento.api_put() failed - #{ex.message}. Trying again..." 
              self.api_put(params, attempts + 1)
            else
              $stderr.puts "Gcore::Api::Connectors::Magento.api_put() Failed - #{ex.message}.. Cannot recover."
              return [{0 => nil}]
            end           
          end                       
        end
        
        def self.api_delete()
          
        end
        
      end
    end
  end
end