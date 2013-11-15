require 'spec_helper'

describe Bill do
  it { should have_db_column(:weekly_schedule_id) }
  it { should have_db_column(:customer_id) }
  it { should have_db_column(:user_id) }
  it { should have_db_column(:delivery_slot_id) }

end
