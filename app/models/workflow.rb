class Workflow
  attr_accessor :file, :input_params

  def initialize(file)
    self.file = file
  end

  def input_descriptor
    @input_descriptor ||= parse_input_descriptor
  end

  def input_ports
    input_descriptor.marshal_dump.keys
  end

  def xml_content
    File.read(file)
  end

  private

  def xml_document
    @xml_document ||= Nokogiri::XML(file)
  end

  def parse_input_descriptor
    input_params = {}
    xml_document.xpath("xmlns:workflow/xmlns:dataflow/xmlns:inputPorts/xmlns:port").each do |port|
      port_name = port.xpath('xmlns:name').first.content
      port_description = port.xpath('.//annotationBean[@class="net.sf.taverna.t2.annotation.annotationbeans.FreeTextDescription"]/text').first
      port_example = port.xpath('.//annotationBean[@class="net.sf.taverna.t2.annotation.annotationbeans.ExampleValue"]/text').first

      values = {}
      values[:description] = port_description.content if port_description
      values[:example] = port_example.content if port_example

      input_params[port_name] = OpenStruct.new(values)
    end

    OpenStruct.new(input_params)
  end

end
