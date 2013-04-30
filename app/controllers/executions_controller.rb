class ExecutionsController < ApplicationController
  load_and_authorize_resource :except => [:notify]
  protect_from_forgery :except => [:notify]
  before_filter :authenticate_user!

  def index
    @executions = current_user.executions.order("created_at DESC").page params[:page]
  end

  def show
    @input_descriptor = @execution.workflow.input_descriptor
    @input_ports = @execution.workflow.input_ports
    @workflow = @execution.workflow
    render :show
  end

  def new
    @workflow = Workflow.find(params[:workflow_id])
    new_count = current_user.executions.count
    @execution = Execution.new(name: "New job #{new_count}")
    @execution.workflow = @workflow
    @execution.set_example_inputs
    show
  end

  def create
    @execution = Execution.new(post_params)
    if @execution.save
      @execution.run!
      redirect_to executions_path
    else
      show
    end
  end

  def update
    @execution.update_attributes(post_params)
    show
  end

  def notify
    @execution = Execution.find_by_taverna_id(params[:id])
    @execution.update_status
    if @execution.finished?
      @execution.update_results
    end
    @execution.save
    redirect_to execution_path(@execution)
  end

  private

  def post_params
    attributes = params[:execution].slice(:name, :description, :input_parameters, :workflow_id)
    attributes[:user_id] = current_user.id
    attributes
  end

end
