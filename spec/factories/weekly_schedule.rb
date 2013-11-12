FactoryGirl.define do
  rand_sched = rand(2.months).from_now.end_of_week(:sunday).utc
  factory :weekly_schedule do
    user
    week_start rand_sched
  end
end

