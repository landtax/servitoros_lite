class Execution < ActiveRecord::Base

  Status = {new: 1 , running: 2, complete: 3, error: 100}

  def server
    @server ||= T2Server.new(server_uri, connection_params)
  end

  def running?
    status == Status[:running]
  end

  def complete?
    status == Status[:complete]
  end

  def error?
    status == Status[:error]
  end

  def run!
    T2Server::Run.create(server_uri, workflow, credentials, connection_params) do |run|
      setup_inputs(run)
      run.start

      self.status = Status[:running]
      self.taverna_id = run.identifier
      self.save
    end
  end


  private 

  def workflow
    File.read(Rails.root.join("config","freeling_tagging_for_crawled_data_610788.t2flow"))
  end

  def credentials
    creds = T2Server::HttpBasic.new('test', 'test11')
  end

  def connection_params
    conn_params = T2Server::DefaultConnectionParameters.new
    conn_params[:verify_peer] = false
    conn_params
  end

  def server_uri
    T2Server::Util.strip_uri_credentials(TAVERNA_SERVER_URI).first
  end

  def setup_inputs run
    inputs = {'language' => 'es'}
    files = {'input_urls' => Rails.root.join('config', 'input1.txt').to_s}

    in_ports = run.input_ports
    in_ports.each_value do |port|
      input = port.name
      if inputs.include? input
        port.value = inputs[input]
      elsif files.include? input
        port.file = files[input]
      end
    end
  end

end
