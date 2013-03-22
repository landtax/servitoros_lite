class ExecutionsController < ApplicationController
  load_and_authorize_resource

  def index
    @executions = current_user.executions.page params[:page]
  end

  def show
  end

  def create
    @execution = Execution.new(post_params)
    if @execution.save
      redirect_to :action => :index
    else
      render :action => :show
    end
  end

  def new
    new_count = current_user.executions.count
    @execution = Execution.new(name: "New job #{new_count}")
    render :show
  end


  private

  def post_params
    attributes = params[:execution].slice(:name, :description)
    attributes[:user_id] = current_user.id
    attributes
  end

end
