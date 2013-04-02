require 'spec_helper'

describe Execution do

  subject { FactoryGirl.build(:execution) }

  it "should require name" do
    subject.name = ""
    expect(subject).to_not be_valid
  end

  it { expect(subject.running?).to be_false }

  it "runs" do
    subject.run!
    expect(subject.initialized?).to be_true
    expect(subject.taverna_id).not_to be_nil
  end

  it "run, wait and parse results" do
    subject.run!
    subject.wait!.should == :finished
    subject.update_results
    subject.results.keys.should == ["output_url"]
    subject.results["output_url"].size.should == 2
  end
end
