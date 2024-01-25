require 'rails_helper'

RSpec.feature 'Transaction Show Page', type: :feature do
  let!(:user) { create(:user) }
  let!(:transaction) { create(:transaction, author: user) }

  before do
    login_as(user, scope: :user)
    visit transaction_path(transaction)
  end

  scenario 'User visits the transaction show page' do
    expect(page).to have_css('div.w-full')
    expect(page).to have_content('Details')

    expect(page).to have_content(transaction.name)
    expect(page).to have_content("$#{transaction.amount}")
    expect(page).to have_content(transaction.created_at.strftime('%d %b %Y'))

    expect(page).to have_link('Edit', href: edit_transaction_path(transaction))
    expect(page).to have_button('Delete')
  end

  scenario 'User clicks on "Edit" link' do
    click_link 'Edit'
    expect(page).to have_current_path(edit_transaction_path(transaction))
  end
end
