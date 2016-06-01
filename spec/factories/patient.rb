FactoryGirl.define do

  factory :patient do
    sequence(:email) { |n| "email#{n}@factory.com" }
    password "password"
  end

end
