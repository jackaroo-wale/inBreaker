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
    @users = User.all
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = "Team created successfully!"
      redirect_to @team
    else
      flash.now[:success] = "Failed to create team: #{team_errors(@team)}"
      render :new
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, user_ids: [])
  end

  def set_team
    @team = Team.find(params[:id])
  end

  def team_errors(team)
    team.errors.full_messages.join(", ")
  end
end
