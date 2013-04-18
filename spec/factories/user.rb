FactoryGirl.define do
  factory :user do
    id 10
    email "test_mail@mymail.com"
    password "mypassword"

    ignore do
      executions_count 5
      workflow_count 3
    end

    after(:create) do |user, evaluator|
      FactoryGirl.create_list(:execution, evaluator.executions_count, user_id: user.id)
    end

    after(:create) do |user, evaluator|
      FactoryGirl.create_list(:workflow, evaluator.workflow_count, user_id: user.id)
    end

  end

end
