class WorkflowsController < ApplicationController

  def index
    @workflows = Workflow.order("name DESC").page params[:page]
  end

  def new
    @workflow = Workflow.new(name: "New workflow")
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


  private

  def post_params
    params[:workflow].slice(:name, :description, :taverna_workflow)
  end
end
