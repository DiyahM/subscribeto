FactoryGirl.define do
  factory :invoice do
    weekly_schedule
    customer
    user
    due_date 30.days.from_now
  end
end
