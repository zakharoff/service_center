require 'rails_helper'

feature 'Log in app' do
  given(:staff) { Staff.create!(email: 'email_stuff@test.com', password: '12345678') }
  given(:client) { Client.create!(email: 'email_client@test.com', password: '12345678') }

  describe 'Staff' do
    background do
      visit root_path
      click_on 'Log in as staff'
    end

    scenario 'registered can log in', js: true do
      fill_in 'Email', with: staff.email
      fill_in 'Password', with: staff.password
      click_on 'Log in'

      expect(page).to have_content 'Hello staff!'
      expect(page).to have_current_path(staffs_home_index_path)
    end

    scenario 'unregistered can not log in' do
      fill_in 'Email', with: 'email_wrong@test.com'
      fill_in 'Password', with: '12345678'
      click_on 'Log in'

      expect(page).to have_content 'Invalid Email or password'
    end
  end

  describe 'Client' do
    background do
      visit root_path
      click_on 'Log in as client'
    end

    scenario 'registered can log in', js: true do
      fill_in 'Email', with: client.email
      fill_in 'Password', with: client.password
      click_on 'Log in'

      expect(page).to have_content 'Hello client!'
      expect(page).to have_current_path(clients_home_index_path)
    end

    scenario 'unregistered can not log in' do
      fill_in 'Email', with: 'email_wrong@test.com'
      fill_in 'Password', with: '12345678'
      click_on 'Log in'

      expect(page).to have_content 'Invalid Email or password'
    end
  end

  describe 'Protect multiple users models' do
    scenario 'staff can not log in client namespace' do
      visit new_client_session_path
      fill_in 'Email', with: staff.email
      fill_in 'Password', with: staff.password
      click_on 'Log in'

      expect(page).to have_content 'Invalid Email or password'
    end

    scenario 'staff can not entry in client namespace' do
      visit new_staff_session_path
      fill_in 'Email', with: staff.email
      fill_in 'Password', with: staff.password
      click_on 'Log in'

      visit(clients_home_index_path)

      expect(page).to_not have_current_path(clients_home_index_path)
    end

    scenario 'client can not log in staff namespace' do
      visit new_staff_session_path
      fill_in 'Email', with: client.email
      fill_in 'Password', with: client.password
      click_on 'Log in'

      expect(page).to have_content 'Invalid Email or password'
    end

    scenario 'client can not entry in staff namespace' do
      visit new_client_session_path
      fill_in 'Email', with: client.email
      fill_in 'Password', with: client.password
      click_on 'Log in'

      visit(staffs_home_index_path)

      expect(page).to_not have_current_path(staffs_home_index_path)
    end
  end
end
