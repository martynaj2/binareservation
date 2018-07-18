class AdminsController < ApplicationController

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

	def verify
			@user = User.find(params[:id])
			if @user.update_attribute(:is_verified, true)
				redirect_to '/admins#index', notice: 'User Updated'
			else
				render :index
			end
	end

end
