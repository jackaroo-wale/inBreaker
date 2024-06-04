class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users =  if params[:search]
                User.where("email iLIKE ?", "%#{params[:search]}%")
              else
                User.all
              end
  end

  def search
    @users = User.where('email iLIKE ?', "%#{params[:search]}%")
    render json: @users
  end

  def show
    @user = User.find(params[:id])
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
