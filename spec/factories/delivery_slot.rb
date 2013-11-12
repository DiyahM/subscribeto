FactoryGirl.define do
  rand_time = Time.at(rand * Time.now.to_i)
  factory :delivery_slot do
    user
    day Date::DAYNAMES.sample
    start_time rand_time
  end
end

