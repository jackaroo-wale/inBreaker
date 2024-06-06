class TeamsController < ApplicationController
  before_action :set_team, only: [:show]

  before_action :authenticate_user!

  def index
    if @team.present?
      @week_number = @team.week_number
    elsif current_user.members.any?
      @team = current_user.members.first.team
      if @team.present?
        @week_number = @team.week_number
      else
        flash[:alert] = "No teams associated with the current user."
        redirect_to root_path and return
      end
    else
      flash[:alert] = "Team not found."
      redirect_to root_path and return
    end

    @weekly_questions = WeeklyQuestion.all
    @weekly_answer = current_user.weekly_answers.build
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
    params.require(:team).permit(:name, user_ids: [])
  end

  def set_team
    @team = Team.find_by(id: params[:team_id])
  end
end
