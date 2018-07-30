class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.where(verified: true)
    @not_verified_users = User.not_verified
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    @user = User.find(params[:id])
    if @user.update(admin_params)
      redirect_to administrator_path, notice: 'User Updated'
    else
      render :edit
    end
  end

  def verify
    @user = User.find(params[:id])
    if @user.update_attribute(:verified, true)
      redirect_to administrator_path, notice: 'User Verified'
    else
      render :index
    end
  end

  def verify_all
    @users_new = User.not_verified.update_all(verified: true)
    redirect_to administrator_path, notice: 'Users Verified'
  end

  private

  def admin_params
    params.require(:user).permit(:premium, :verified, :password, :password_confirmation)
  end
end
