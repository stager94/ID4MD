FactoryGirl.define do

  factory :doctor do
    sequence(:email) { |n| "email#{n}@factory.com" }
    password "password"
  end

end
