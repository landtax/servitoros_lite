outputs = {:output1 => [{value: "https://link.com/1", size: 123}, {value: "http://link.com/2", size: 1032}]}

FactoryGirl.define do
  factory :execution do
    status :new
    name 'New execution'
    description 'Nex execution description'
    input_parameters "input1, input2"
    results outputs
  end
end
