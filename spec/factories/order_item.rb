FactoryGirl.define do
  quant = rand(100)
  
  factory :order_item do
    item
    bill
    price_charged rand(10)
    quantity quant
    qty_delivered quant
    qty_returned 0
  end

end
