class TransactionsController < ApplicationController
  def create
  	@buyer = User.find(params[:buyer_id])
  	@seller = User.find(params[:seller_id])
  	@product = Product.find(params[:product_id])
  	amount = params[:amount]
  	@transaction = Transaction.new(buyer:@buyer,seller:@seller,product:@product,amount:amount)
    if !@transaction.valid?
      flash[:errors] = @transaction.errors.full_messages
      redirect_to :back
      
    else
      @transaction.save
      redirect_to "/products"
    end
  end

  def destroy
  end
end
