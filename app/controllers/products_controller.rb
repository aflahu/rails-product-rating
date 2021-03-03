class ProductsController < ApplicationController
  before_action do
    case action_name.to_sym
    when :new, :create
      @product = Product.new
    when :show, :edit, :update, :destroy
      @product = Product.find(params[:id])
    end
  end

  def new
    @store = []
    @stores = Store.select(:name, :id)
    @stores.each do |store|
      @store.append([store.name, store.id])
    end
  end

  def create
    @product.assign_attributes(product_params)
    if @product.save
      redirect_to products_url
    else
      flash[:error] = @product.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
    @rating = 0
    @length = 0
    
    @product.purchases.each do |purchase|
      @review  = Review.find_by(purchase_id: purchase.id)
      if @review
          if @review.rating != 0
            @rating += @review.rating
            @length += 1
          end
      end
    end

    if @length != 0
      @rating = @rating /  @length
    end
    
  end

  def index
    @products = Product.all    
  end

  private
    def product_params
      params.require(:product).permit(:name, :quantity, :price, :store_id)
    end
end  
