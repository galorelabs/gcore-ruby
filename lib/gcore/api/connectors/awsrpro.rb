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
          with_meta = params[:with_meta]
           
          url = "#{Gcore::Api.endpoint}/connectors/awsrpro/#{store_code}"
          
          if (with_meta === true)
            response = RestClient.get(url, Gcore::Api.header)
            return [JSON.parse(response), response.headers]
          else
            return JSON.parse(RestClient.get(url, Gcore::Api.header))
          end
                     
         end      
      end
    end
  end
end