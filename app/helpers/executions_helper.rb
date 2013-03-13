module ExecutionsHelper

  def execution_status_class(execution)
    case execution.status
       when :running  then "info"
       when :error then "error"
       end
  end

end
