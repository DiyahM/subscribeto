step "I enter order :quantity of :item for :customer at :delivery_slot" do |quantity,item,customer,delivery_slot|
  page.find(:xpath, "//table//tr[contains(.,'#{delivery_slot}')]/following-sibling::tr[contains(.,'#{customer}')][1]/child::td//input[contains(@class,'#{item}')]").set(quantity)  
end
