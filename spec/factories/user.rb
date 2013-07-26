FactoryGirl.define do
  factory :user do
    company_name "OrderOrchard"
    name  "Johnny Walker"
    sequence(:email) {|n| "email#{n}@factory.com" }
    password "password"
    password_confirmation "password"
  end
end

