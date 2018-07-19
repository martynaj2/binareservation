class AdminsController < ApplicationController
	before_action :authenticate_admin!

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
		if @user.update(admin_params)
			redirect_to '/admins#index', notice: 'User Updated'
		else
			render :edit
		end
	end


	def verify
			@user = User.find(params[:id])
			if @user.update_attribute(:is_verified, true)
				redirect_to '/admins#index', notice: 'User Updated'
			else
				render :index
			end
	end

	private

	def admin_params
		params.require(:user).permit(:name, :surname, :email, :is_premium, :is_verified, :password, :password_confirmation)
	end

end
