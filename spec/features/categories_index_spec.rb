require 'rails_helper'

RSpec.feature 'Categories Index Page', type: :feature do
  include ActionView::Helpers::NumberHelper
  let!(:user) { create(:user) }
  let!(:categories) { create_list(:category, 3) }

  before do
    login_as(user, scope: :user)
    visit categories_path
  end

  it 'displays the header and categories' do
    expect(page).to have_css('div.flex.bg-main')
    expect(page).to have_content('categories')
    expect(page).to have_link('Create new category', href: new_category_path)

    categories.each do |category|
      expect(page).to have_css("#categories #category_#{category.id}")
      expect(page).to have_content(category.name)
      expect(page).to have_content(number_to_currency(category.financial_transactions.sum(:amount)))
    end
  end

  it 'displays "Details" and "Edit" links for each category' do
    categories.each do |category|
      expect(page).to have_link('Details', href: category_path(category))
      expect(page).to have_link('Edit', href: edit_category_path(category))
    end
  end

  it 'redirects to "Create new category" page when clicking the link' do
    click_link 'Create new category'
    expect(page).to have_current_path(new_category_path)
  end
end
