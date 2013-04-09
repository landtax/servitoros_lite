require 'spec_helper'

describe Workflow do
  subject { Workflow.new(File.open(Rails.root.join('spec/support/workflow_example.t2flow'))) }

  it "should return the correct input params" do
    correct_input_descriptor = {'input_urls' => OpenStruct.new({ 'example' => "http://nlp.ilsp.gr/panacea/D4.3/data/201109/ENV_ES/1.xml\nhttp://nlp.ilsp.gr/panacea/D4.3/data/201109/ENV_ES/2.xml",
                                             'description' => 'A list of URL to BasicXces files. It can also work with "file://" urls.' }),
                                             'language' => OpenStruct.new({ 'example' => "es", 'description' =>  "Language" })}

    expect(subject.input_descriptor).to eq OpenStruct.new(correct_input_descriptor)
  end

end
