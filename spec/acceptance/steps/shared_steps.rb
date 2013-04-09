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
