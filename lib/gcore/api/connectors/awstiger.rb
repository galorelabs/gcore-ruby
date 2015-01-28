require 'json'
require 'rest-client'

module Gcore
  class Api
    class Connectors
      class Awstiger
        def self.list(params = {})
          #Backwards compatible with store_id,
          #But most appropriate with store_code
          store_code = params[:store_id] || params[:store_code]
          with_meta = params[:with_meta]

          url = "#{Gcore::Api.endpoint}/connectors/awstiger/#{store_code}"

          if (with_meta === true)
            response = RestClient.get(url, Gcore::Api.header)
            return [JSON.parse(response, {symbolize_names: true}), response.headers]
          else
            return JSON.parse(RestClient.get(url, Gcore::Api.header), {symbolize_names: true})
          end

        end
      end
    end
  end
end