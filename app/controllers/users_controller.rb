class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def destroy
	    @user = User.find(params[:id])
	    @user.destroy
	end

	def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to '/users#index', notice: 'User Updated'
    else
      render :edit
    end
  end

	private

	def user_params
		params.require(:user).permit(:name, :surname, :email, :is_premium)
		#params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
	end

end
