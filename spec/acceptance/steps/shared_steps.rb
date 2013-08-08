step "I am logged in" do
  @user = FactoryGirl.create(:user)
  visit('/login')
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button("Login")
end

step "I don't already have an account" do
end

step "I visit :path" do |path|
  visit("/#{path}")
end

step "I click :text" do |text|
  click_on(text)
end

step "I fill in :field with :text" do |field, text|
  fill_in field, with: text
end

step "I should see :text" do |text|
  page.should have_content(text)
end

step "I should not see :text" do |text|
  page.should_not have_content(text)
end

step "I select :text for :field" do |text, field|
  select text, from: field
end

step "I have customer(s) named :customers" do |customers|
  customers.split(', ').each_with_index do |customer, i|
    @user.customers.create!(company_name: customer, email: "test#{i}@test.com")
  end
end

step "I have customer(s) :customers assigned to delivery slot :slot" do |customers, slot|
  day = slot.split(' at ').first
  time = slot.split(' at ').last
  delivery_slot = @user.delivery_slots.create(day: day, start_time: Time.utc(2013,1,1,time))
  customers.split(', ').each do |customer|
    i = @user.customers.count + 1
    @user.customers.create!(company_name: customer, delivery_slot_ids: [delivery_slot.id], email: "test#{i}@test.com")
  end
end

step "I do not have any customers" do
  @user.customers.destroy_all
end

step "I do not have any delivery slots" do
  @user.delivery_slots.destroy_all
end

step "I do not have any items" do
  @user.items.destroy_all
end

step "I have delivery slot(s) :slots" do |slots|
  slots.split(', ').each do |slot|
    day = slot.split(' at ').first
    time = slot.split(' at ').last
    @user.delivery_slots.create(day: day, start_time: Time.utc(2013,1,1,time))
  end
end

step "I have item(s) :items" do |items|
  items.split(', ').each do |item|
    @user.items.create!(name: item, price: "5.00")
  end
end

step "I click the :action link for :name" do |action, name|
  find(:xpath, "//tr[td[contains(.,'#{name}')]]/td/a", :text => action).click
end
