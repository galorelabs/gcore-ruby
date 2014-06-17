module Gcore
  class Api
  
    @@setup = { 
      api_key: nil, 
      api_secret: nil, 
      endpoint: "https://api.gcore.galoretv.com",
      mock: false
    }
    
    def self.setup
      yield @@setup
    end
    
    def self.api_key
      raise "Please configure your api_key first." if @@setup[:api_key].nil?
      @@setup[:api_key]
    end
    
    def self.api_secret
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
      "#{self.api_key}:#{self.api_secret}"
    end    
    
  
  end
end