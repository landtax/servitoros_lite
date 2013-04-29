class WorkflowsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource 
  check_authorization 

  def index
    @workflows = current_user.workflows.order("name DESC").page params[:page]
  end

  def new
    @workflow = Workflow.new(name: "New workflow")
    render :show
  end

  def show
    @workflow = Workflow.find(params[:id])
  end

  def create
    @workflow = Workflow.new(post_params)
    @workflow.user = current_user

    if @workflow.save
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def update
    @workflow = Workflow.find(params[:id])
    @workflow.update_attributes(put_params)
    render :show
  end


  private

  def put_params
    params[:workflow].slice(:name, :description)
  end

  def post_params
    params[:workflow].slice(:name, :description, :taverna_workflow)
  end
end
