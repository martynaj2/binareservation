class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
		@users = User.all
	end

	def edit
		@user = User.find(current_user.id)
  end

  def update
		if current_user.is_admin
			@user = User.find(params[:id])
	    if @user.update(admin_params)
	      redirect_to '/admins#index', notice: 'User Updated'
	    else
	      render :edit
	    end
		else
			@user = User.find(params[:id])
	    if @user.update(user_params)
	      redirect_to '/users#index', notice: 'User Updated'
	    else
	      render :edit
	    end
		end
  end

	private

	def admin_params
		params.require(:user).permit(:name, :surname, :email, :is_premium, :is_verified)
	end

	def user_params
		params.require(:user).permit(:name, :surname, :email)
		#params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
	end

end
