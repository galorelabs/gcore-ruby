require 'json'
require 'rest-client'

module Gcore
  class Api
    class Stores
      def self.list
        url = "#{Gcore::Api.endpoint}/stores"
        JSON.parse(RestClient.get(url, Gcore::Api.header))        
      end
      
      def self.show(params = {})
        store_code = params[:store_id] || params[:store_code] 
        url = "#{Gcore::Api.endpoint}/stores/#{store_code}"
        JSON.parse(RestClient.get(url, Gcore::Api.header))      
      end
      
    end
  end
end