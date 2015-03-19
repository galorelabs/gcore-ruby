require 'json'
require 'rest-client'
require 'base64'
require 'gcore/api/exceptions'
require 'bigdecimal'

module Gcore
  class Api
    class Stores
      class Products
        
        #Display single sales order
        def self.show(params = {})
           store_code = params[:store_id] || params[:store_code]
           sku = params[:sku]
           url = "#{Gcore::Api.endpoint}/stores/#{store_code}/products/#{sku}"
           begin
            return JSON.parse(RestClient.get(url, Gcore::Api.header),  {symbolize_names: true})
           rescue RestClient::ResourceNotFound
             raise Gcore::Api::Exceptions::SalesOrderNotFoundException.new(store_code: store_code, order_number: order_number )
           end           
        end
        
        def self.list(params = {})
          store_code = params[:store_id] || params[:store_code]
          allowed_params = [:limit, :page]
          url_params = params.select{|key, value| allowed_params.include? key} || {}           
          url = "#{Gcore::Api.endpoint}/stores/#{store_code}/products"
          JSON.parse(RestClient.get(url, Gcore::Api.header.merge(params: url_params)), {symbolize_names: true})                
        end
        
        def self.mass_update(params = {})
            store_code = params[:store_id] || params[:store_code]
            verbose_mode = params[:verbose_mode]
            body = params[:body]
            url = "#{Gcore::Api.endpoint}/stores/#{store_code}/products"
            
            #We are concerned with the header only
            resp = RestClient.put(url, body.to_json, Gcore::Api.header).headers
            output = resp.select{|key, value| [:location, :x_batch].include? key}
            
            #Poll the result

            loop do
                begin 
                    #Use HEAD for faster polling instead of GET
                    results = RestClient.head("#{Gcore::Api.endpoint}#{output[:location]}", Gcore::Api.header).headers
                    results.select!{|key, value| [:x_object_processed, :x_object_count].include? key}
                    results[:percentage] = ((BigDecimal.new(results[:x_object_processed]) / BigDecimal.new(results[:x_object_count])) * BigDecimal.new("100")).to_s("F")
                    results[:batch] = output[:x_batch]
                    if verbose_mode
                        Gcore::Api.logger.puts(results)
                    end
                    break if results[:x_object_processed].to_i >= results[:x_object_count].to_i
                rescue RestClient::ResourceNotFound
                    #Carry on, loop again.
                rescue StandardError => ex
                    Gcore::Api.logger.puts({message: ex.message, class: ex.class.name})
                end
                sleep 1
            end
            
            JSON.parse(RestClient.get("#{Gcore::Api.endpoint}#{output[:location]}", Gcore::Api.header), {symbolize_names: true})  
        end
        
        def self.skus(params = {})
             store_code = params[:store_id] || params[:store_code]
             url = "#{Gcore::Api.endpoint}/stores/#{store_code}/products/skus"
             JSON.parse(RestClient.get(url, Gcore::Api.header), {symbolize_names: true})
        end

        # PUT /stores/cudsly/products/quantity        
        def self.mass_update_quantity(params = {})
            store_code = params[:store_id] || params[:store_code]
            delta = params[:delta]
            verbose_mode = params[:verbose_mode]
            body = params[:body]
            url = "#{Gcore::Api.endpoint}/stores/#{store_code}/products/quantity"
            url =+ "?delta=true" if delta

            #We are concerned with the header only
            resp = RestClient.put(url, body.to_json, Gcore::Api.header).headers
            output = resp.select{|key, value| [:location, :x_batch].include? key}

            #Poll the result

            loop do
                begin 
                    #Use HEAD for faster polling instead of GET
                    results = RestClient.head("#{Gcore::Api.endpoint}#{output[:location]}", Gcore::Api.header).headers
                    results.select!{|key, value| [:x_object_processed, :x_object_count].include? key}
                    results[:percentage] = ((BigDecimal.new(results[:x_object_processed]) / BigDecimal.new(results[:x_object_count])) * BigDecimal.new("100")).to_s("F")
                    results[:batch] = output[:x_batch]
                    if verbose_mode
                        Gcore::Api.logger.puts(results)
                    end
                    break if results[:x_object_processed].to_i >= results[:x_object_count].to_i
                rescue RestClient::ResourceNotFound
                    #Carry on, loop again.
                rescue StandardError => ex
                    Gcore::Api.logger.puts({message: ex.message, class: ex.class.name})
                end
                sleep 1
            end
            
            JSON.parse(RestClient.get("#{Gcore::Api.endpoint}#{output[:location]}", Gcore::Api.header), {symbolize_names: true})  
        end
        

        
      end
    end
  end
end
