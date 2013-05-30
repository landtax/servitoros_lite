module ExecutionsHelper

  def execution_status_class(execution)
    case execution.status
    when :running  then "label-info"
    when :finished  then "label-success"
    when :error then "label-important"
    end
  end

end
