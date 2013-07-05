FactoryGirl.define do
  factory :item do
    sequence(:name) {|n| "Item#{n}"}
    price "5.00"
    user
  end
end
