require 'rails_helper'

RSpec.feature "Users", type: :feature do
  before do
    @user = create(:user)
  end

  scenario "signs me in" do
    visit root_path
    click_on "Log in"

    within("form#new_user") do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
    end

    click_button 'Log in'
    expect(page).to have_content "Welcome #{@user.name}"
  end

end
