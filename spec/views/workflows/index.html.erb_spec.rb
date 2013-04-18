require 'spec_helper'

describe "workflows/index.html.erb" do

  let(:user) { create(:user) }
  let(:workflows) { user.workflows.page(1) } 

  it "list executions" do
    assign(:workflows, workflows)
    render
    rendered.should have_selector("tr", :count => 4)
    rendered.should have_selector("a.btn>i.icon-play", :count => 3)
  end
end
