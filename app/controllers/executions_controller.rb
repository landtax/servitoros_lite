class ExecutionsController < ApplicationController
  load_and_authorize_resource :except => [:notify]
  protect_from_forgery :except => [:notify]
  check_authorization :except => [:notify]

  def index
    @executions = current_user.executions.page params[:page]
  end

  def show
  end

  def new
    new_count = current_user.executions.count
    @execution = Execution.new(name: "New job #{new_count}")
    render :show
  end

  def create
    @execution = Execution.new(post_params)
    if @execution.save
      @execution.run!
      redirect_to :action => :index
    else
      render :action => :show
    end
  end

  def notify
    execution = Execution.find_by_taverna_id(params[:id])
    execution.update_status
    if execution.finished?
      execution.update_results
    end
    execution.save
    render :nothing => true
  end

  private

  def post_params
    attributes = params[:execution].slice(:name, :description)
    attributes[:user_id] = current_user.id
    attributes
  end

end
