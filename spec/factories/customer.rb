FactoryGirl.define do
  factory :customer do
    company_name "Foo Inc"
    sequence(:email) {|n| "customer#{n}.factory.com"}
  end
end
