require 'rails_helper'

RSpec.feature 'Categories New View', type: :feature do
  let!(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
    visit new_category_path
  end

  scenario 'displays the "Create new group" heading' do
    expect(page).to have_content('Create new group')
  end

  scenario 'displays the form' do
    expect(page).to have_selector('form')
  end

  scenario 'displays the submit button' do
    expect(page).to have_button('Save')
  end

  scenario 'displays the "Back to groups" link' do
    expect(page).to have_link('Back to groups', href: categories_path)
  end
end
