class TeamsController < ApplicationController
  before_action :set_team, only: [:show]
  before_action :authenticate_user!

  def index
    # raise
    @teams = current_user.teams
    @team = @teams.first
  end

  def show
    @team = Team.find(params[:id])
    @chatroom = @team.chatrooms.first
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.week_number == 1
    if @team.save
      if params[:team][:user_ids].present?
        params[:team][:user_ids].each do |user_id|
          unless Member.exists?(user_id: user_id, team_id: @team.id)
            Member.create(user_id: user_id, team_id: @team.id, weekly_points: 0, total_points: 0)
          end
          member = Member.find_by(user_id: user_id, team_id: @team.id)
          member.weekly_points = 0
          member.total_points = 0
          member.save
        end
      end
      Member.create(user_id: current_user.id, team_id: @team.id, weekly_points: 0, total_points: 0)
      Chatroom.create(name: @team.name, team: @team)
      redirect_to teams_path
      flash[:success] = "Team created successfully!"
    else
      flash.now[:error] = "Failed to create team."
      render :new
    end
  end

  private

  def team_params
    params.require(:team).permit(:team_image, :name, user_ids: [])
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
