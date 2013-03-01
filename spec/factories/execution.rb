FactoryGirl.define do
  factory :execution do
    status Execution::Status[:new]
  end
end
