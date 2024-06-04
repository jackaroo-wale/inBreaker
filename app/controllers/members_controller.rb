class MembersController < ApplicationController
  before_action :set_team, only: [:create]
  before_action :authenticate_user!

  def create
    # @member = Member.new(member_params)
    # if @member.save
    #   redirect_to @member
    # else
    #   render 'new'
    # end

    # @user = User.find(params[:user_id])
    # if !@team.user.include?(@user)
    #   @team_member = Member.create(email: @user, team: @team)
    #   respond_to do |format|
    #     format.html { redirect_to @team, notice: "User added in team!" }
    #     format.json { render json: { success: true }}
    #   end
    # else
    #   respond_to do |format|
    #     format.html { redirect_to @team, alert: "User already in team" }
    #     format.json { render json: { error: "User already in team" }}
    #   end
    # end

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
