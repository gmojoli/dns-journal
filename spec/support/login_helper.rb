module LoginHelpers
  
  def login_as(role)
    @user = create(role)
    login_with(@user)
  end
  
  def login_with(user)
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "123456789"
    click_button "Sign in"
  end

  def logout
    click_link "Logout" rescue nil
  end
end
