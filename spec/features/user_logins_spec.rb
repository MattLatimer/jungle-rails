require 'rails_helper'

RSpec.feature "Visitor navigates to product page", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create!(
      name: 'a',
      email: 'a@a.a',
      password: 'aaaaaaaa',
      password_confirmation: 'aaaaaaaa'
    )
  end

  
  scenario "They login" do
    
    # ACT
    visit root_path
    find_link('Login').click 
    
    within 'form' do
      fill_in id: 'email', with: 'a@a.a'
      fill_in id: 'password', with: 'aaaaaaaa'
      click_button('Submit')
    end
    
    expect(page).to have_text 'Logout'    

    # DEBUG / VERIFY
    save_screenshot
    
  end

end