FactoryGirl.define do
  factory :user do
    id 10
    email "test_mail@mymail.com"
    password "mypassword"

    ignore do
      executions_count 5
    end

    after(:create) do |user, evaluator|
      FactoryGirl.create_list(:execution, evaluator.executions_count, user_id: user.id)
    end

  end

end
