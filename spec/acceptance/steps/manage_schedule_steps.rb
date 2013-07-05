step "I enter :value for :field for :item for :delivery_slot" do |value, field, item, delivery_slot|
  fill_in field, with: value
end
