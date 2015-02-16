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
           
          url = "#{Gcore::Api.endpoint}/connectors/awsrpro/#{store_code}/async"
          resp = RestClient.post(url, {}, Gcore::Api.header)
          response_location = resp.headers[:location]
          response_url = "#{Gcore::Api.endpoint}#{response_location}"
          output = ""
          
          loop do
              
            repeat_request = false
            
            begin 
                output = RestClient.get(response_url, Gcore::Api.header)
            rescue RestClient::Exception => ex
                repeat_request = true
                sleep(0.25) #Do not overwhelm the server
            end
            
            break if !repeat_request
          end
          
          if (with_meta === true)
            return [JSON.parse(output, {symbolize_names: true}), output.headers]
          else
            return JSON.parse(output, {symbolize_names: true})
          end
                     
         end      
      end
    end
  end
end