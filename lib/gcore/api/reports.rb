#TODO: {symbolize_names: true} for JSON.parse

require 'rest_client'
require 'json'

module Gcore
  class Api
    class Reports
    
      def self.show(params)
      
        store = params[:store].to_s
        report_name = params[:report_name].to_s
      
        JSON.parse(RestClient.get("#{Gcore::Api.endpoint}/reports/#{store}/#{report_name}", 
          :content_type => :json, 
          :accept => :json, 
          :timeout => -1, 
          :open_timeout => -1, 
          :authorization => Gcore::Api.authorization))          
      end
      
      def self.create(params, attempts=1)
        begin
          
          store = params[:store].to_s
          report_name = params[:report_name].to_s
          key = params[:key]
          value = params[:value]
          date = params[:date]
          extra = params[:extra]
          
          body = { key: key, value: value, date: date, extra: extra}
          
          JSON.parse(RestClient.post("#{Gcore::Api.endpoint}/reports/#{store}/#{report_name}", 
            body.to_json, 
            :content_type => :json, 
            :accept => :json, 
            :timeout => -1, 
            :open_timeout => -1, 
            :authorization => Gcore::Api.authorization))     
        rescue StandardError => ex
          if attempts <= 10
            $stderr.puts "Gcore::Api::Products.create() failed - #{ex.message}. Trying again..." 
            self.create(params, attempts + 1)
          else
            $stderr.puts "Gcore::Api::Products.create() failed - #{ex.message}. Cannot recover."
            return {}
          end
        end
      end
      
      def self.destroy(params)
      
        store = params[:store]
        report_name = params[:report_name]
      
        JSON.parse(RestClient.delete("#{Gcore::Api.endpoint}/reports/#{store}/#{report_name}", 
          :content_type => :json, 
          :accept => :json, 
          :timeout => -1, 
          :open_timeout => -1, 
          :authorization => Gcore::Api.authorization))          
      end      
  
      
    end
  end
end