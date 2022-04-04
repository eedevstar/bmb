require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  let(:user) { create(:user_with_posts) }
  let(:comment) { "Test Comment" }

  before do
    sign_in user
    visit root_path
  end

  scenario "add comment with blank invoke error" do
    first(".link-title").click

    expect(page).to have_button "Create Comment"

    fill_in "Comment", with: comment

    click_button "Create Comment"

    expect(page).to have_content comment
  end
end
