FactoryGirl.define do
  factory :user do
    company_name "OrderOrchard"
    name  "Johnny Walker"
    sequence(:email) {|n| "email#{n}@factory.com" }
    password "password"
    password_confirmation "password"

    factory :user_with_customer do
      after(:create) do |user|
        FactoryGirl.create_list(:customer, user: user)
      end
    end
  end

  
end

