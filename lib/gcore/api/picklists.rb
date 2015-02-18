#TODO: {symbolize_names: true} for JSON.parse

require 'rest_client'
require 'json'

module Gcore
  class Api
    class Picklists

      def self.show(params)

        picklist_number = params[:picklist_number]
        params.delete(:picklist_number)

        JSON.parse(RestClient.get("#{Gcore::Api.endpoint}/picklists/#{picklist_number}",
        :params => params,
        :content_type => :json,
        :accept => :json,
        :timeout => -1,
        :open_timeout => -1,
        :authorization => Gcore::Api.authorization))
      end

      def self.list(params = {})

        params[:limit] = params[:limit] || Gcore::Api::LIST_LIMIT
        params[:page] = params[:page] || 1

        JSON.parse(RestClient.get("#{Gcore::Api.endpoint}/picklists",
                                  :params => params,
                                  :content_type => :json,
                                  :accept => :json,
                                  :timeout => -1,
                                  :open_timeout => -1,
                                  :authorization => Gcore::Api.authorization), {symbolize_names: true})
      end

      def self.create(params)
        begin

          #return {} if params.nil? || params.empty?
          params_body = params.select{|key, value| [:sales_orders].include? key}

          url = "#{Gcore::Api.endpoint}/picklists"

          JSON.parse(RestClient.post(url,
                                     params_body.to_json,
                                     :content_type => :json,
                                     :accept => :json,
                                     :authorization => Gcore::Api.authorization), {symbolize_names: true})
        rescue => e
            $stderr.puts "Gcore::Api::Picklists.create() failed - #{e.message}."
        end
      end

    end
  end
end