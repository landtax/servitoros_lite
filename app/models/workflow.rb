class Workflow < ActiveRecord::Base
  attr_accessor :input_params
  attr_accessible :name, :description, :taverna_workflow
  has_attached_file :taverna_workflow

  belongs_to :user

  def input_descriptor
    @input_descriptor ||= parse_input_descriptor
  end

  def input_ports
    input_descriptor.marshal_dump.keys
  end

  def xml_content
    File.read(File.open(taverna_workflow.path))
  end

  def example_inputs_parameters
    examples = {:inputs => {}, :files => {}}
    input_ports.each do |port|
      examples[:inputs][port] = input_descriptor.send(port).example
    end
    examples
  end

  private

  def xml_document
    @xml_document ||= Nokogiri::XML(File.read(taverna_workflow.path))
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
