class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def search
    @users = User.where("email LIKE ?", "%#{params[:email]}%")
                 .where.not(id: current_user.id)
    render json: @users
  end


  def show
    if params[:id] == 'search'
      @users = User.where("email LIKE ?", "%#{params[:email]}%")
      render json: @users
    else
      @user = User.find(params[:id])
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
