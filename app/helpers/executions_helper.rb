module ExecutionsHelper

  def execution_status_class(execution)
    case execution.status
    when :initialized  then "label-warning"
    when :running  then "label-warning"
    when :finished  then "label-success"
    when :error then "label-important"
    end
  end

  def execution_status_name(execution)
    return execution.status.to_s.humanize unless execution.initialized?
    "In progress"
  end

end
