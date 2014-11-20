#These are class methods of API needed to do a class-level
#setup of Gcore::Api 

# We separate this to allow "declarative programming"
# In Gcore::Api

require 'yaml'


module Gcore
  class Api

    def self.configure_using_yaml(need_configure_yaml)
      if need_configure_yaml
        ### Read configuration file, if it exists
        config = {}
        begin
          file_path = "#{Dir.home}/.gcore/gcore.yaml"     
          config = YAML.load_file(file_path)
          puts "Configuration loaded from #{file_path}"
          @@setup.each_key do |key|
            @@setup[key] = config[key.to_s]
          end
        rescue
          #Problems? Carry on. Load config in another way.
        end
      end
    end

     def self.set_list_limit(limit)
      @@list_limit = limit
    end
    
    def self.initialize_setup_parameters
    @@setup = { 
      api_key: nil, 
      api_secret: nil, 
      endpoint: "https://api.gcore.galoretv.com",
      mock: false
    }
    
    
    def self.list_limit
      @@list_limit
    end        
        
    end    
    end
end