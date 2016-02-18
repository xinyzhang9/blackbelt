class UsersController < ApplicationController
# after_action :buy_sum,:sell_sum
  def create
  	@user = User.new(user_params)
    if !@user.save
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
      
    else
      @user.save
      session[:user_id] = @user.id
      redirect_to "/products"
    end
  end

  def show
  	@users = User.all
  	@user = User.find(params[:id])
  	@products = Product.all
  	@my_products = Product.where(["user_id=?",current_user.id]) 
  	@transactions = Transaction.all

  	@my_bought_transactions = Transaction.where(:buyer_id => current_user.id)
  	@my_sold_transactions = Transaction.where(:seller_id => current_user.id)

  end
  	def buy_sum
	  	@buy_sum = 0
	  	my_bought_transactions = Transaction.where(:buyer_id => current_user.id)
	  	if my_bought_transactions
		  	my_bought_transactions.each do |t|
		  		amount = t.amount.to_f
		  		@buy_sum += amount
		  	end
	  	end
	  	return @buy_sum
  	end

  	def sell_sum
	  	@sell_sum = 0
	  	my_sold_transactions = Transaction.where(:seller_id => current_user.id)
		  	if my_sold_transactions
		  	my_sold_transactions.each do |t|
		  		amount = t.amount.to_f
		  		@sell_sum += amount
		  	end
	  		
	  	end
	  	return @sell_sum
  	end

  	helper_method :buy_sum,:sell_sum

  
  
  private
  def user_params
    params.require(:user).permit(:email,:first_name,:last_name,:password)
  end
end
