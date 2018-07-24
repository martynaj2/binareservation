class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
		@users = User.all
	end

	def edit
		@user = User.find(current_user.id)
  end

  def update
		@user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to users_path, notice: 'User Updated'
    else
      render :edit
    end
  end

	private

	def user_params
		params.require(:user).permit(:name, :surname, :email, :avatar, :avatar_cache, :remove_avatar)
	end

end
