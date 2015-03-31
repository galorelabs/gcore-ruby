require 'rest_client'
require 'json'

module Gcore
  class Api
    class Inventory
      class InventoryMaster

        def self.show(params)

          local_params = params.clone
          id = local_params[:id]
          local_params.delete(:id)

          JSON.parse(RestClient.get("#{Gcore::Api.endpoint}/inventory/items/#{id}",
                                    :params => local_params,
                                    :content_type => :json,
                                    :accept => :json,
                                    :timeout => -1,
                                    :open_timeout => -1,
                                    :authorization => Gcore::Api.authorization), {symbolize_names: true})
        end

        def self.list(params)
          JSON.parse(RestClient.get("#{Gcore::Api.endpoint}/inventory/items",
                                    :params => params,
                                    :content_type => :json,
                                    :accept => :json,
                                    :timeout => -1,
                                    :open_timeout => -1,
                                    :authorization => Gcore::Api.authorization), {symbolize_names: true})
        end

        def self.list_all(params)

          return_value = []
          params[:page] = 1

          loop {
            inventory_items = JSON.parse(RestClient.get("#{Gcore::Api.endpoint}/inventory/items",
                                                        :params => params,
                                                        :content_type => :json,
                                                        :accept => :json,
                                                        :timeout => -1,
                                                        :open_timeout => -1,
                                                        :authorization => Gcore::Api.authorization), {symbolize_names: true})

            break if inventory_items.length == 0

            return_value.concat(inventory_items)
            params[:page] += 1
          }

          return return_value

        end
      end
    end
  end
end