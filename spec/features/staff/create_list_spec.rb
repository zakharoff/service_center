require 'rails_helper'

feature 'Staff can use dashboard', js: true do
  given(:staff) { Staff.create!(email: 'email_stuff@test.com', password: '12345678') }
  given(:client) { Client.create!(email: 'email_client@test.com', password: '12345678',
                                  fullname: 'Derp Bob', phone: '12345678') }

    background { sign_in_staff(staff) }

    scenario 'can view client' do
      expect(page).to have_content client.email
      expect(page).to have_content client.fullname
      expect(page).to have_content client.phone
    end

    scenario 'not not view submit when not valid form' do
      fill_in placeholder: 'fullname', with: 'email_wrong@test.com'
      fill_in placeholder: 'phone', with: '123321'

      expect(page).to_not have_content 'SUBMIT'
    end

  scenario 'can create client' do
    fill_in placeholder: 'fullname', with: 'Jack Sparrow'
    fill_in placeholder: 'phone', with: '555666'
    fill_in placeholder: 'email', with: 'email_test@test.com'
    fill_in placeholder: 'pasword', with: '12345678'

    expect(page).to have_content 'Jack Sparrow'
    expect(page).to have_content '555666'
    expect(page).to have_content 'email_test@test.com'
  end
end
