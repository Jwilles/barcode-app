class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :index]
 
  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Grocery App!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to root_path    
    else
      render 'edit'
    end
  end

  private
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in"
        redirect_to login_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
