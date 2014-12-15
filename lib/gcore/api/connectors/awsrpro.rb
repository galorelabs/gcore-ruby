require 'json'
require 'rest-client'

module Gcore
  class Api
    class Connectors
      class Awsrpro      
         def self.list(params = {})
          #Backwards compatible with store_id,
          #But most appropriate with store_code         
          store_code = params[:store_id] || params[:store_code] 
          url = "#{Gcore::Api.endpoint}/connectors/awsrpro/#{store_code}"
          JSON.parse(RestClient.get(url, Gcore::Api.header))           
         end      
      end
    end
  end
end