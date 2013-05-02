Servitoros::Application.config.taverna_server = OpenStruct.new(YAML.load_file(Rails.root.join("config/taverna_server.yml").to_s)[Rails.env])
