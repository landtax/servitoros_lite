require 'spec_helper'

describe "executions/show.html.erb" do

  let(:user) { create(:user) }
  let(:execution) { user.executions.first } 
  let(:workflow) { execution.workflow }
  let(:input_descriptor) { workflow.input_descriptor }
  let(:input_ports) { workflow.input_ports }
  before do
    assign(:execution, execution)
    assign(:input_ports, input_ports)
    assign(:input_descriptor, input_descriptor)
  end

  it "should show input fields for workflow paramters" do
    render
    expect(rendered).to have_selector("textarea[name='execution[input_parameters][inputs][input_urls]']")
    expect(rendered).to have_selector("textarea[name='execution[input_parameters][inputs][language]']")
  end

  it "show properties when available" do
    execution.taverna_id = "taverna_id_1234"
    render
    expect(rendered).to have_selector("textarea[name='execution[input_parameters][inputs][input_urls]']")
    expect(rendered).to have_content("taverna_id_1234")
    expect(rendered).to have_content("Execution Properties")
  end

  it "should hide properties when not available" do
    execution.taverna_id = nil
    render
    expect(rendered).to_not have_content("Execution Properties")
  end

  it "show execution results" do
    execution.status = :finished
    execution.taverna_id = "taverna_id_1234"
    render
    expect(rendered).to have_content("Results")
    expect(rendered).to have_content("Output1")
    expect(rendered).to have_content("Download")
    expect(rendered).to have_selector("ol>li>a", :count => 2)
  end

  it "should hide execution results" do
    execution.status = :initialized
    execution.taverna_id = "taverna_id_1234"
    render
    expect(rendered).to_not have_content("Results")
    expect(rendered).to_not have_selector("ol>li>a", :count => 2)
    expect(rendered).to_not have_content("Ouput1")
  end


end
