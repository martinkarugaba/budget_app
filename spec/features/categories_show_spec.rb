require 'rails_helper'

RSpec.feature 'Categories Show View', type: :feature do
  let!(:user) { create(:user) }
  let!(:category) { create(:category, name: 'Test Category') }

  before do
    login_as(user, scope: :user)
    visit category_path(category)
  end

  scenario 'displays the category details heading' do
    expect(page).to have_content('Category Details')
  end

  scenario 'displays the category name' do
    expect(page).to have_content('Test Category')
  end

  scenario 'displays a "Back" link' do
    expect(page).to have_link('Back')
  end
end
