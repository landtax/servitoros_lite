class ExecutionsController < ApplicationController
  load_and_authorize_resource :except => [:notify]
  protect_from_forgery :except => [:notify]
  helper_method :current_or_guest_user

  def index
    @execution = Execution.new()
    @execution.workflow = Workflow.last
    @execution.set_example_inputs

    @input_descriptor = @execution.workflow.input_descriptor
    @input_ports = @execution.workflow.input_ports
    @executions = current_or_guest_user.executions.order("created_at DESC").page params[:page]
  end

  def create
    @execution = Execution.new(post_params)
    @execution.workflow = Workflow.last
    if @execution.save
      @execution.run!
    end
    redirect_to executions_path
  end

  def notify
    find_execution_from_notification

    unless @execution.finished?
      @execution.update_status
      if @execution.finished?
        @execution.update_results
      end
      @execution.save
    end

    redirect_to execution_path(@execution)
  end

  def executions_list
    @executions = current_or_guest_user.executions.order("created_at DESC").page params[:page]
    render :partial => 'list'
  end

  private

  def find_execution_from_notification
    taverna_id = params[:id] || params[:content].scan(/ID=(\S+)/).flatten.first
    @execution = Execution.find_by_taverna_id(taverna_id) 
  end

  def post_params
    attributes = params[:execution].slice(:input_parameters)
    attributes[:user_id] = current_or_guest_user.id
    attributes
  end

  def session_id
    request.session_options[:id]
  end

end
