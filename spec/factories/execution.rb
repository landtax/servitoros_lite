FactoryGirl.define do
  factory :execution do
    status :new
    input_parameters "input1, input2"
  end
end
