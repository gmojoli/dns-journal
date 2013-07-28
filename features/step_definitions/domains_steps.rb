
World(Devise::TestHelpers)

Given /^I have domains named (.+)$/ do |names|
  @user = FactoryGirl.create(:user)
  names.split(', ').each do |name|
    Domain.create!(:name => name, :user_id => @user.id)
  end
end

When(/^I go to (.+)$/) do |page_name|
  case page_name
  when 'the list of domains'
    visit domains_path
  end
end

When(/^authenticate$/) do
  visit new_user_session_url  
  fill_in "Email", :with => @user.email  
  fill_in "Password", :with => @user.password
  click_button "Sign in"
  page.has_text? "Logged in as #{@user.email}"
end

Then(/^I should see "(.*?)"$/) do |user_domain|
  page.has_text? user_domain
end