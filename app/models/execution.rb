class Execution < ActiveRecord::Base

  acts_as_model_with_status({new: 1 , initialized: 2, running: 3, finished: 4, error: 100}, :default => :new, :column => :status)

  serialize :output

  belongs_to :user

  validates :name, :presence => true

  def run!
    T2Server::Run.create(server_uri, workflow, credentials, connection_params) do |run|
      setup_inputs(run)
      run.start

      self.status = :initialized
      self.taverna_id = run.identifier
    end
    save
  end

  def wait!
    until finished?
      sleep 1
      update_status
    end
    status
  end

  def update_status
    return unless taverna_id
    self.status = server_run.status
    save
  end

  def update_results
    return unless finished?

    results = {}
    server_run.output_ports.each do |port_id, port|
      outputs = []
      port.value.size.times do |i|
        outputs << {:value => port.value[i], :size => port.size[i] }
      end
      results[port_id] = outputs
    end
    self.results = results
  end

  def update_results!
    update_results
    save
  end

  def finished?
    status == :finished
  end

  def running?
    status == :running
  end

  def initialized?
    status == :initialized
  end

  private 

  def server
    @server ||= T2Server::Server.new(server_uri, connection_params)
  end

  def server_run
    @server_run ||= server.run(taverna_id, credentials)
  end

  def workflow
    File.read(Rails.root.join("config","freeling_tagging_for_crawled_data_610788.t2flow"))
  end

  def credentials
    username = Rails.configuration.taverna_server.username
    password = Rails.configuration.taverna_server.password
    creds = T2Server::HttpBasic.new(username, password)
  end

  def connection_params
    conn_params = T2Server::DefaultConnectionParameters.new
    conn_params[:verify_peer] = false
    conn_params[:ssl_version] = :SSLv3
    conn_params
  end

  def server_uri
    T2Server::Util.strip_uri_credentials(Rails.configuration.taverna_server.uri).first
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
