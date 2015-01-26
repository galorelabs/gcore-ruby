module Gcore
  class Api
    class Exceptions      
      class SalesOrderNotFoundException < StandardError
 
        def initialize(params)
          @order_number = params[:order_number]
          @store_code = params[:store_code]
          super(message)
        end
        
        def message
          "Order Number #{@order_number} does not exist for store #{@store_code}"
        end         
      end      
    end
  end
end