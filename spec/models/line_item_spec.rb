require 'spec_helper'

describe LineItem do

  it { should validate_presence_of(:item_id) }
  it { should validate_presence_of(:delivery_slot_id) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:price) }
end
