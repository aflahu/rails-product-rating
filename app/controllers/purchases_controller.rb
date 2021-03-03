class PurchasesController < ApplicationController
  before_action do
    @product = Product.find(params[:product_id])

    case action_name.to_sym
    when :new, :create
      @purchase = @product.purchases.new
    when :show, :edit, :update, :destroy
      @purchase = @product.purchases.find(params[:id])
    end
  end

  def new
  end

  def create
    # COMPLETED: Also decrease product quantity.
    # - For example, if `purchase.quantity` is 3, decrease `product.quantity` by 3
    # - Display an error if `product.quantity` is less than 0 (negative number)
    @purchase.assign_attributes(purchase_params)

    @product.quantity = @product.quantity - @purchase.quantity
    if @product.quantity < 0
      flash[:error] = "Sorry out of stock"
      render :new
      return
    else
        @product.save
    end
    

    if @purchase.save
      redirect_to product_url(@product)
    else
      flash[:error] = @purchase.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    # COMPLETED: Show edit form
  end

  def update
    # COMPLETED: Update record (save to database)
    @updated_quantity = (@product.quantity + @purchase.quantity) - params[:purchase][:quantity].to_i
    if @updated_quantity <= 0 
      flash[:error] = "Sorry out of stock"
    end
    if @purchase.update(purchase_params)
      @product.quantity = @updated_quantity
      @product.save
      redirect_to product_url(@product), notice: "Purchase was updated succesfully"
    else
      render :edit
    end
  end

  def destroy
    # COMPLETED: Delete record
    @purchase.destroy
    redirect_to product_url(@product), notice: "Purchase was deleted succesfully"
  end

  def show    
    @review = Review.find_by(purchase_id: @purchase.id)
  end

  private
    def purchase_params
      params.require(:purchase).permit(:quantity, :delivery_address)
    end
end  
