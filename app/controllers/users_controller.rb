class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def search
    if params[:q].present?
      @users = User.where('email LIKE ?', "%#{params[:q]}%")
    else
      @users = User.none
    end

    respond_to do |format|
      format.json { render json: @users}
    end
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
