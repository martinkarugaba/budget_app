require 'rails_helper'

RSpec.feature 'Categories Edit View', type: :feature do
  let!(:user) { create(:user) }
  let!(:category) { create(:category, name: 'Test Category') }

  before do
    login_as(user, scope: :user)
    visit edit_category_path(category)
  end

  scenario 'displays the "Edit Category" heading' do
    expect(page).to have_content('Edit Category')
  end

  scenario 'displays the form' do
    expect(page).to have_selector('form')
  end

  scenario 'displays the "Back to categories" link' do
    expect(page).to have_link('Back to categories', href: categories_path)
  end
end
