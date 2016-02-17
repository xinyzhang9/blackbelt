class ProductsController < ApplicationController
  def create
  	@product = Product.new(name:params[:name],amount:params[:amount],user:current_user)
    if !@product.save
      flash[:errors] = @product.errors.full_messages
      redirect_to :back
      
    else
      @product.save
      redirect_to :back
    end
  end

  def index
  	@products = Product.all
  	@users = User.all
  	@transactions = Transaction.all
  end

  def destroy
  	@product = Product.find(params[:id])
  	@product.destroy
  	redirect_to :back
  end
end
