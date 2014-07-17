module Features
  module SessionHelper
    def sign_in_with(email, password)
      visit new_user_session_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      page.find('input.btn').click
    end
  end
end
