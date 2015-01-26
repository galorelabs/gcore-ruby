require 'gcore/api_module'


module Gcore
  class Api  
    #deprecated. Use Api.list_limit
    LIST_LIMIT ||= 25
    
    initialize_setup_parameters    
    configure_using_yaml true
    set_list_limit 25
    

    def self.setup
      yield @@setup
    end
    
    #Deprecated. There is no need to retrieve the API KEY. Use Api.authorization instead.
    def self.api_key
      $stderr.puts "Deprecated. There is no need to retrieve the API KEY. Use Api.authorization instead."
      raise "Please configure your api_key first." if @@setup[:api_key].nil?
      @@setup[:api_key]
    end
    
     #Deprecated. There is no need to retrieve the API Secret. Use Api.authorization instead.
    def self.api_secret
      $stderr.puts "#Deprecated. There is no need to retrieve the API Secret. Use Api.authorization instead."
      raise "Please configure your api_secret first." if @@setup[:api_secret].nil?
      @@setup[:api_secret]
    end
    
    def self.endpoint
      raise "Please configure your endpoint first." if @@setup[:endpoint].nil?
      @@setup[:endpoint]
    end
    
    def self.mock?
      @@setup[:mock]
    end
    
    def self.authorization
      raise "Please configure Gcore::Api first." if !@@setup[:api_key] || !@@setup[:api_secret] 
      "#{@@setup[:api_key]}:#{@@setup[:api_secret]}"
    end
    
    def self.header
       {content_type: :json, accept: :json, :authorization => Gcore::Api.authorization}
    end

  end
  
end