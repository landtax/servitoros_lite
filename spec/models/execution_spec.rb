require 'spec_helper'

describe Execution do

  subject { FactoryGirl.build(:execution) }

  it { expect(subject.is_running?).to be_false }

  it "runs" do
    subject.run!
    expect(subject.is_running?).to be_true
    expect(subject.taverna_id).not_to be_nil
  end
end
