class Execution < ActiveRecord::Base

  Status = {new: 1 , running: 2, complete: 3, error: 100}

  def run!
    workflow = File.read(Rails.root.join("config","freeling_tagging_for_crawled_data_610788.t2flow"))
    creds = T2Server::HttpBasic.new('test', 'test11')
    conn_params = T2Server::ConnectionParameters.new

    T2Server::Run.create(TAVERNA_SERVER_URI, workflow, creds, conn_params) do |run|
      self.status = Status[:running]
      self.taverna_id = run.identifier
      self.save
    end
  end


  def is_running?
    status == Status[:running]
  end

  def is_complete?
    status == Status[:complete]
  end

  def had_errors?
    status == Status[:error]
  end

end
