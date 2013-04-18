outputs = {:output1 => [{value: "https://link.com/1", size: 123}, {value: "http://link.com/2", size: 1032}]}
inputs = {:inputs => {'input_urls' => "http://link.com/input1\nhttp://link.com/input2", 'language' => "en"}, :files => {}}

FactoryGirl.define do
  factory :execution do
    status :new
    name 'New execution'
    description 'Nex execution description'
    input_parameters inputs
    results outputs
    workflow {FactoryGirl.create(:workflow)}
  end
end
