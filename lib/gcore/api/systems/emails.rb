require 'rest_client'
require 'json'

module Gcore
  class Api
    class Systems
      class Emails
        def self.create(params, attempts=1)
          params_body = params.select{|key, value| [:to, :subject, :body].include? key}
                    
          begin                    
            JSON.parse(RestClient.post("#{Gcore::Api.endpoint}/systems/emails", 
              params_body.to_json, 
              :content_type => :json, 
              :accept => :json, 
              :authorization => Gcore::Api.authorization), {symbolize_names: true})     
          rescue StandardError => ex
            if attempts <= 10
              $stderr.puts "Gcore::Api::Systems.Locks.create() failed - #{ex.message}. Trying again..." 
              self.create(params, attempts + 1)
            else
              $stderr.puts "Gcore::Api::Systems.Locks.create() failed - #{ex.message}. Cannot recover."
              return {}
            end          
          end
        end        
      end
    end
  end
end