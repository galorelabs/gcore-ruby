#TODO: {symbolize_names: true} for JSON.parse
require 'rest_client'
require 'json'


module Gcore
  class Api
    module Systems
      class Locks
        
        def self.create(params, attempts=1)
          params_body = params.select{|key, value| [:name, :expires_at].include? key}
                    
          begin                    
            JSON.parse(RestClient.post("#{Gcore::Api.endpoint}/systems/locks", 
              params_body.to_json, 
              :content_type => :json, 
              :accept => :json, 
              :timeout => -1, 
              :open_timeout => -1, 
              :authorization => Gcore::Api.authorization))     
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
        
        def self.delete(params)
           permitted_params = params.select{|key, value| [:name].include? key}

          begin                    
            JSON.parse(RestClient.delete("#{Gcore::Api.endpoint}/systems/locks/#{permitted_params[:name]}", 
              :content_type => :json, 
              :accept => :json, 
              :timeout => -1, 
              :open_timeout => -1, 
              :authorization => Gcore::Api.authorization))     
          rescue StandardError => ex
            if attempts <= 10
              $stderr.puts "Gcore::Api::Systems.Locks.delete() failed - #{ex.message}. Trying again..." 
              self.create(params, attempts + 1)
            else
              $stderr.puts "Gcore::Api::Systems.Locks.delete() failed - #{ex.message}. Cannot recover."
              return {}
            end          
          end 
          
        end
        
      end
    end
  end
end