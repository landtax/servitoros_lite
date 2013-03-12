class ExecutionsController < ApplicationController

  def index
    @executions = current_user.executions
  end

  def show
    @execution = Execution.find(params[:id])
  end

  def create
    @execution = Execution.create(post_params)
    redirect_to execution_path(@execution)
  end

  def new
    @execution = Execution.new
    @execution.user = current_user
    render :show
  end


  private

  def post_params
    attributes = params[:execution].slice(:input_parameters)
    attributes[:user_id] = current_user.id
    attributes
  end

end
