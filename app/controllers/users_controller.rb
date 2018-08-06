class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
    unless logged_in?
      redirect_to login_path, flash: { danger: "Pour accéder à cette page, il faut d'abord vous connecter." }
    end
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = 'Voili voilou'
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user.update_attributes(user_params)
    flash[:success] = 'Profil mis à jour'
    redirect_to @user
  end

  def destroy
    @user.destroy
    redirect_to '/'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
