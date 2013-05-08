require 'spec_helper'

describe Execution do

  subject { FactoryGirl.build(:execution) }

  it "should require name" do
    subject.name = ""
    expect(subject).to_not be_valid
  end

  it { expect(subject.running?).to be_false }

  it "run, wait and parse results" do
    subject.should_receive(:create_taverna_run).and_return("taverna_id_1234")
    subject.run!
    expect(subject.initialized?).to be_true
    expect(subject.taverna_id).to eq "taverna_id_1234"

    subject.should_receive(:server_run).twice.and_return(double({status: :finished}))
    subject.should_receive(:update_results)
    subject.wait

    expect(subject.status).to eq :finished
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
