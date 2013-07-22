FactoryGirl.define do
  factory :uploaded_file do 
    name "My uploaded file"
    description "uploaded file description text"
    file { File.new(File.join(Rails.root, 'spec', 'fixtures', 'workflow_example.t2flow')) }
  end
end
