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
  visit(path)
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

step "I select :text for :field" do |text, field|
  select text, from: field
end

step "I have customer(s) named :customers" do |customers|
  customers.split(', ').each do |customer|
    @user.customers.create(company_name: customer)
  end
end

step "I have delivery slot(s) :slots" do |slots|
  slots.split(', ').each do |slot|
    day = slot.split(' at ').first
    time = slot.split(' at ').last
    @user.delivery_slots.create(day: day, start_time: Time.new(2013,1,1,time))
  end
end

step "I have item(s) :items" do |items|
  items.split(', ').each do |item|
    @user.items.create(name: item)
  end
end


step "I click the :action link for :name" do |action, name|
  find(:xpath, "//tr[td[contains(.,'#{name}')]]/td/a", :text => action).click
end
