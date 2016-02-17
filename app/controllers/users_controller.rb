class UsersController < ApplicationController
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

  def user_params
    params.require(:user).permit(:email,:first_name,:last_name,:password)
  end
end
