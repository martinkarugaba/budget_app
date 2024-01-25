require 'rails_helper'

RSpec.feature 'Categories Show Page', type: :feature do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:transactions) { create_list(:transaction, 3, author: user, categories: [category]) }

  before do
    login_as(user, scope: :user)
    visit category_path(category)
  end

  it 'displays the header with back button' do
    expect(page).to have_css('div.w-full')
    expect(page).to have_content('Transactions')
  end

  it 'displays financial transactions' do
    transactions.each do |transaction|
      expect(page).to have_content(transaction.name)
      expect(page).to have_content("$#{transaction.amount}")
    end
  end

  it 'displays "Create New Transaction" button' do
    expect(page).to have_link('Create New Transaction', href: new_transaction_path)
  end
end
