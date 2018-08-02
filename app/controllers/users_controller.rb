class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def edit
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to profile_path, notice: 'User Updated'
    else
      render :edit
    end
  end

  def vacation
    @user = User.find(params[:id])
    if @user.vacation == true
      @user.update(vacation: false)
      # UserMailer.vacation_false_mail(@user).deliver_now
    else
      @user.update(vacation: true)
      # UserMailer.vacation_true_mail(@user).deliver_now
    end
    redirect_to profile_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :email, :avatar, :avatar_cache, :remove_avatar, :vacation)
  end
end
