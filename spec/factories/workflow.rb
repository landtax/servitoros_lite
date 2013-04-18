FactoryGirl.define do
  factory :workflow do 
    name "My workflow"
    description "Workflow description text"
    taverna_workflow { File.new(File.join(Rails.root, 'spec', 'support', 'workflow_example.t2flow')) }
  end
end
