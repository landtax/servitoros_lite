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
    subject.wait
    expect(subject.status).to eq :finished
    expect(subject.results.keys).to eq ["output_url"]
    expect(subject.results["output_url"].size).to eq 2
  end

  it "should serialize correcly results" do
    subject.status = :finished
    
    results = {:output_1 => [{value: 1, description: 1}, {value: 2, description: 2}]}
    subject.results = results
    subject.save
    subject.reload
    expect(subject.results.class).to eq results.class
    expect(subject.results).to eq results
  end
end
