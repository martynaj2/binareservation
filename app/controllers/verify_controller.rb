class VerifyController < ApplicationController

	def index
		@users = User.all
	end

	def show
    @user = User.find(params[:id])
  end

	def edit
		@user = User.find(params[:id])
		if @user.update_attribute(:is_verified, true)
			redirect_to '/verify#index', notice: 'User Updated'
		else
			render :index
		end
	end

end
