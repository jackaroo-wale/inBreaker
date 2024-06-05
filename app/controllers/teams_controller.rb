class TeamsController < ApplicationController
  before_action :set_team, only: [:show]
  before_action :set_user_and_member, only: [:new, :create]
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
    if @team.save
      redirect_to root_path
      flash[:success] = "Team created successfully!"
    else
      flash[:error] = "Failed to create team."
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

  def set_user_and_member
    @user = current_user
  end
end
