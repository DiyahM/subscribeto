step "I have a customer named :name" do |name|
  @user.customers.create(company_name: name)  
end

step "I click the :action link for :name" do |action, name|
  find(:xpath, "//tr[td[contains(.,'#{name}')]]/td/a", :text => action).click
end
