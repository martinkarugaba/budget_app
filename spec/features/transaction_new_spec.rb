require 'rails_helper'

RSpec.feature 'Transaction New Page', type: :feature do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }

  before do
    login_as(user, scope: :user)
    visit new_transaction_path
  end

  scenario 'User visits the new transaction page' do
    # Check if the header is displayed correctly
    expect(page).to have_css('div.flex.bg-main')

    # Check if the heading is displayed
    expect(page).to have_content('Create new transaction')

    # Check if the form is present
    expect(page).to have_selector('form')

    # Check if the "Transactions" link is present
    expect(page).to have_link('Transactions', href: transactions_path)
  end

  scenario 'User creates a new transaction' do
    # Check if the header is displayed correctly
    expect(page).to have_css('div.flex.bg-main')

    # Check if the heading is displayed
    expect(page).to have_content('Create new transaction')

    # Check if the form is present
    expect(page).to have_selector('form')

    # Fill in the form with valid data
    fill_in 'Name', with: 'New Transaction'
    fill_in 'Amount', with: 100

    # Find the label associated with the checkbox and check it
    check(find('label', text: category.name)['for'])

    # Submit the form
    click_button 'Create Transaction'

    # Check if the user is redirected to the transactions page
    expect(page).to have_current_path(transactions_path)

    # Check if the flash message is displayed
    expect(page).to have_content('Entity was successfully created.')

    # Check if the new transaction details are reflected in the view
    expect(page).to have_content('New Transaction')
    expect(page).to have_content('$100')
  end
end
