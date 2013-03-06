module ActsAsModelWithStatus

  class Railtie < Rails::Railtie
    config.to_prepare do
      ActiveRecord::Base.send(:extend, ActsAsModelWithStatus::Hook)
    end
  end

  module Hook
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def acts_as_model_with_status options
        @_statuses = {new: 1 , initialized: 2, running: 3, finished: 4, error: 100}
        @_invert_statuses = @_statuses.invert
      end

      def status
        status_id = read_attribute :status
        @_invert_statuses[status_id] if status_id
      end

      def status= value
        status_id = @_statuses[value]
        write_attribute :status, status_id  if status_id
      end

      def initialized?
        status == :initialized
      end

      def running?
        status == :running
      end

      def finished?
        status == :finished
      end

      def error?
        status == :error
      end
    end
  end

end

