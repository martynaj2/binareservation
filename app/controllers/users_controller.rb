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

	def verify
		@user = User.find(params[:id])
		if @user.update_attribute(:is_verified?, true)
			redirect_to '/users#index', notice: 'User Updated'
		else
			render :index
		end

	end

	private

	def user_params
		params.require(:user).permit(:name, :surname, :email)
		#params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
	end

end
