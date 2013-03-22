FactoryGirl.define do
  factory :execution do
    status :new
    name 'New execution'
    description 'Nex execution description'
    input_parameters "input1, input2"
  end
end
