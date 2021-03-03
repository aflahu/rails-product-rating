
# Completed: Implement 
class StoresController < ApplicationController
    before_action do
        case action_name.to_sym
        when :new, :create
          @store = Store.new
        when :show, :edit, :update, :destroy
          @store = Store.find(params[:id])
        end
      end
    
      def new
      end
    
      def create
        @store.assign_attributes(store_params)
        if @store.save
          redirect_to stores_url
        else
          flash[:error] = @store.errors.full_messages.join(', ')
          render :new
        end
      end
    
      def show
        @rating = 0
        @length = 0

        @store.products.each do |product|
            product.purchases.each do |purchase|
                @review  = Review.find_by(purchase_id: purchase.id)
                if @review
                    if @review.rating != 0
                      @rating += @review.rating
                      @length += 1
                    end
                end
              end
        end       
       
    
        if @length != 0
          @rating = @rating /  @length
        end
        
      end
    
      def index
        @stores = Store.all    
      end
    
      private
        def store_params
          params.require(:store).permit(:name, :url)
        end
end
