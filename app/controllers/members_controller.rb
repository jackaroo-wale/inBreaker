class MembersController < ApplicationController
  before_action :set_team, only: [:create]
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    @member = @team.members.build(user: @user)
    if @member.save
      render json: { success: true, user: @user }
    else
      render json: { success: false, errors: @member.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    @members = Member.includes(:user, :team).all
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new
  end

  private

  def member_params
    params.require(:member).permit(:weekly_points, :total_points)
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
