require 'spec_helper'

describe Order do
  
  it { should validate_presence_of(:customer_id) }
  it { should validate_presence_of(:user_id) }
end
