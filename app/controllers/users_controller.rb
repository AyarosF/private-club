class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :logged_in_user, only: %i[index edit update]
  before_action :correct_user, only: %i[edit update]

  def index
    @users = User.all
    unless logged_in?
      redirect_to login_path, flash: { danger: 'Connecte-toi pour accéder à la page privée.' }
    end
  end

  def show
    unless logged_in?
      redirect_to login_path, flash: { danger: 'Connecte-toi pour accéder à cette page' }
    end
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = 'Bienvenue !!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Ton profil a été mis à jour'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = 'Connecte-toi ici'
      redirect_to login_url
    end
  end

  def destroy
    @user.destroy
    redirect_to '/'
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      redirect_to root_path, flash: { danger: "Tu crois quand même pas qu'on va te laisser éditer le profil d'un autre ?" }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
