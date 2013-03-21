require 'spec_helper'

describe "executions/index.html.erb" do

  let(:user) { create(:user) }
  let(:executions) { user.executions.page(1) } 

  it "list executions" do
    assign(:executions, executions)
    render
    rendered.should have_selector("tr", :count => 6)
  end
end
