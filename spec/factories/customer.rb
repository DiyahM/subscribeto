FactoryGirl.define do
  factory :customer do
    company_name "Foo Inc"
    sequence(:email) {|n| "customer#{n}.factory.com"}
    term "Net 30"
    user
  end
end
