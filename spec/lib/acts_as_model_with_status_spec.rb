require 'spec_helper'

describe ActsAsModelWithStatus do

  class BasicModel < ActiveRecord::Base
    acts_as_model_with_status({:new => 1, :running => 2, :done => 3, :closed => 4})
  end

  class WithDefaultModel < ActiveRecord::Base
    acts_as_model_with_status({:new => 1, :running => 2, :done => 3, :closed => 4}, :default => 2)
  end

  class WithColumnModel < ActiveRecord::Base
    acts_as_model_with_status({:new => 1, :running => 2, :done => 3, :closed => 4}, :default => 2, :column => :my_status)
  end


  it { expect(subject.running?).to be_false }

  describe "Status values" do
    subject { model = BasicModel.new }

    it { expect(subject.status).to be_nil }

  end
end
