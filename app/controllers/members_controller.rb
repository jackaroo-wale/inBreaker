class MembersController < ApplicationController
  before_action :set_team, only: [:create]
  before_action :authenticate_user!

  def create
    @team = Team.find(params[:team_id])
    @user = User.find(params[:user_id])
    @team.member.create(user: @user)
    render json: { success: true, user: @user}
  end

  def index
    @members = Member.all
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
