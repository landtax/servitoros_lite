class ExecutionsController < ApplicationController

  def index
    @executions = current_user.executions
  end

  def show
    @execution = Execution.find(params[:id])
  end

  def create
    @execution = Execution.create(:user => current_user)
  end

  def new
    @execution = Execution.new
    @execution.user = current_user
    render :show
  end
end
