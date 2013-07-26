require 'spec_helper'

describe DeliverySlot do
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:day) }
  it { should validate_presence_of(:user_id) }
end
