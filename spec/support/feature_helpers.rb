module FeatureHelpers
  def sign_in_client(client)
    visit new_client_session_path
    fill_in 'Email', with: client.email
    fill_in 'Password', with: client.password
    click_on 'Log in'
  end

  def sign_in_staff(staff)
    visit new_staff_session_path
    fill_in 'Email', with: staff.email
    fill_in 'Password', with: staff.password
    click_on 'Log in'
  end
end
