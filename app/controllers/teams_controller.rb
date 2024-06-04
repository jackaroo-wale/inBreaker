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
    if @team.save
      params[:user_ids].each do |user_id|
        @team.members.create(user_id: user_id)
      end
      redirect_to @team, notice: 'Team was successfully created'
    else
      render 'new'
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
