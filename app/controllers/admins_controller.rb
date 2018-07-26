class AdminsController < ApplicationController
	before_action :authenticate_admin!

	def index
		@users = User.where(verified: true)
		@not_verified_users = User.where(verified: nil).or(User.where(verified: false))
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
			redirect_to admins_path, notice: 'User Updated'
		else
			render :edit
		end
	end

	def verify
			@user = User.find(params[:id])
			if @user.update_attribute(:verified, true)
				redirect_to admins_path, notice: 'User Verified'
			else
				render :index
			end
	end

	def verify_all
			@users_new = User.where(verified: nil).or(User.where(verified: false)).update_all(verified: true)

			redirect_to admins_path, notice: 'Users Verified'
	end

	private

	def admin_params
		params.require(:user).permit(:name, :surname, :email, :premium, :verified, :password, :password_confirmation)
	end

end
