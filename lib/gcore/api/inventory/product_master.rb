require 'rest_client'
require 'json'

module Gcore
  class Api
    class Inventory
      class ProductMaster

        #Display single product master item
        def self.show(params = {})
          store_code = params[:store_id] || params[:store_code]
          local_params = params.clone
          id = local_params[:id]
          local_params.delete(:id)

          JSON.parse(RestClient.get("#{Gcore::Api.endpoint}/product/master/#{store_code}/items/#{id}",
                                    :params => local_params,
                                    :content_type => :json,
                                    :accept => :json,
                                    :timeout => -1,
                                    :open_timeout => -1,
                                    :authorization => Gcore::Api.authorization), {symbolize_names: true})
        end

        def self.list(params = {})
          store_code = params[:store_id] || params[:store_code]
          params.delete(:store_code)
          url = "#{Gcore::Api.endpoint}/products/master/#{store_code}/items"
          JSON.parse(RestClient.get(url, Gcore::Api.header.merge(params: params)), {symbolize_names: true})
        end

        def self.list_all(params = {})
          return_value = []
          params[:page] = 1
          store_code = params[:store_id] || params[:store_code]
          params.delete(:store_code)
          url = "#{Gcore::Api.endpoint}/products/master/#{store_code}/items"

          loop {
            product_items = JSON.parse(RestClient.get(url,
                                                        :params => params,
                                                        :content_type => :json,
                                                        :accept => :json,
                                                        :timeout => -1,
                                                        :open_timeout => -1,
                                                        :authorization => Gcore::Api.authorization), {symbolize_names: true})

            break if product_items.length == 0

            return_value.concat(product_items)
            params[:page] += 1
          }

          return return_value
        end

      end
    end
  end
end