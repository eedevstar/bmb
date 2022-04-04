require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  let(:user) { create(:user_with_posts, posts_count: 15) }
  let(:title) { "Test Title" }
  let(:content) { "Test Body Content" }

  before do
    sign_in user
    visit root_path
  end

  scenario "add new post with success" do
    click_on "New Post"

    within("form#new_post") do
      fill_in "Title", with: title
      fill_in "Content", with: content
    end

    click_button "Create Post"

    expect(page).to have_content title
    expect(page).to have_content "Total Posts: 16"
  end

  scenario "add new post with blank invoke error" do
    click_on "New Post"

    within("form#new_post") do
      fill_in "Title", with: ""
      fill_in "Content", with: ""
    end

    click_button "Create Post"

    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Content can't be blank"
  end

  scenario "edit post and save" do
    click_on "Edit", match: :first

    fill_in "Title", with: title

    click_button "Save"

    expect(page).to have_content title
  end

  scenario "delete post", js: true do
    page.accept_confirm do
      click_on "Delete", match: :first
    end

    expect(page).to have_content "Total Posts: 14"
  end
end
