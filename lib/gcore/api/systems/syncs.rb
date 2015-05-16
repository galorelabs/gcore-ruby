module Gcore
  class Api
    class Systems
       class Syncs
         def self.show(params)

           local_params = params.clone
           id = local_params[:id]
           local_params.delete(:id)

           JSON.parse(RestClient.get("#{Gcore::Api.endpoint}/systems/syncs/#{id}",
                                     :params => local_params,
                                     :content_type => :json,
                                     :accept => :json,
                                     :timeout => -1,
                                     :open_timeout => -1,
                                     :authorization => Gcore::Api.authorization), {symbolize_names: true})

         end
       end
    end
  end
end