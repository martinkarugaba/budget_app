require 'rails_helper'

RSpec.feature 'Category Index Page', type: :feature do
  let!(:user) { create(:user) }
  let!(:categories) { create_list(:category, 3) }

  before do
    login_as(user, scope: :user)
    visit categories_path
  end

  it 'displays the header and categories' do
    expect(page).to have_css('div.w-full.border-orange-500')
    expect(page).to have_content('categories')

    # Check if each category is displayed
    categories.each do |category|
      expect(page).to have_css("#categories #category_#{category.id}")
      expect(page).to have_content(category.name)
    end

    # Check for "Create new category" button
    expect(page).to have_link('Create new category', href: new_category_path)
  end

  it 'displays category names' do
    categories.each do |category|
      expect(page).to have_content(category.name)
    end
  end

  it 'redirects to the new category page when "Create new category" is clicked' do
    click_link 'Create new category'
    expect(page).to have_current_path(new_category_path)
  end
end
