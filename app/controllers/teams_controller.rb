class TeamsController < ApplicationController
  before_action :set_team, only: [:show]

  before_action :authenticate_user!

  def index
    @teams = current_user.teams
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    # raise
    if @team.save
      if params[:team][:user_ids].present?
        params[:team][:user_ids].each do |user_id|
          Member.create(user_id: user_id, team_id: @team.id)
        end
      end

      redirect_to teams_path
      flash[:success] = "Team created successfully!"
    else
      flash[:error] = "Failed to create team."
      render :new
    end

  end

  private

  def team_params
    params.require(:team).permit(:name, :searchQuery, user_ids: [])
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
