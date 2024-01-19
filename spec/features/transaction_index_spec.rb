require 'rails_helper'

RSpec.feature 'Transaction Index Page', type: :feature do
  let!(:user) { create(:user) }
  let!(:transactions) { create_list(:transaction, 3, author: user) }

  before do
    login_as(user, scope: :user)
    visit transactions_path
  end

  scenario 'User visits the transaction index page and sees the header' do
    # Check if the header is displayed correctly
    expect(page).to have_css('div.flex.bg-main')
  end

  scenario 'User visits the transaction index page and sees the New transaction link' do
    # Check if the "New transaction" link is present
    expect(page).to have_link('New transaction', href: new_transaction_path)
  end

  scenario 'User visits the transaction index page and sees the transactions' do
    # Check if the transactions are displayed
    transactions.each do |transaction|
      expect(page).to have_content(transaction.name)
      expect(page).to have_content("$#{transaction.amount}")
      expect(page).to have_content(transaction.created_at.strftime('%d %b %Y'))
    end
  end

  scenario 'User visits the transaction index page and sees the Details and Edit links' do
    # Check if the Details and Edit links are displayed
    transactions.each do |transaction|
      expect(page).to have_link('Details', href: transaction_path(transaction))
      expect(page).to have_link('Edit', href: edit_transaction_path(transaction))
    end
  end
end
