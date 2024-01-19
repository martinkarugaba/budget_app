require 'rails_helper'

RSpec.feature 'Transaction Show Page', type: :feature do
  let!(:user) { create(:user) }
  let!(:transaction) { create(:transaction, author: user) }

  before do
    login_as(user, scope: :user)
    visit transaction_path(transaction)
  end

  scenario 'User visits the transaction show page' do
    # Check if the header is displayed correctly
    expect(page).to have_css('div.flex.bg-main')

    # Check if the transaction details are displayed
    expect(page).to have_content('Transaction Details')
    expect(page).to have_content(transaction.name)
    expect(page).to have_content("$#{transaction.amount}")
    expect(page).to have_content(transaction.created_at.strftime('%d %b %Y'))

    # Check if the "Edit" link is present
    expect(page).to have_link('Edit', href: edit_transaction_path(transaction))

    # Check if the "Delete" button is present
    expect(page).to have_button('Delete')

    # Check if the "Back" link is present
    expect(page).to have_link('Back', href: transactions_path)
  end

  scenario 'User clicks on "Edit" link' do
    click_link 'Edit', href: edit_transaction_path(transaction)
    expect(page).to have_current_path(edit_transaction_path(transaction))
  end

  scenario 'User clicks on "Delete" button' do
    # Assuming you don't have JavaScript confirmation for delete
    click_button 'Delete'
    expect(page).to have_current_path(transactions_path)
    expect(page).to have_content('Entity was successfully destroyed.')
  end

  scenario 'User clicks on "Back" link' do
    click_link 'Back', href: transactions_path
    expect(page).to have_current_path(transactions_path)
  end
end
