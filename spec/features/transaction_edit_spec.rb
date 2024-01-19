require 'rails_helper'

RSpec.feature 'Edit Transaction Page', type: :feature do
  let!(:user) { create(:user) }
  let!(:transaction) { create(:transaction, author: user) }

  before do
    login_as(user, scope: :user)
    visit edit_transaction_path(transaction)
  end

  scenario 'User visits the edit transaction page and sees the header' do
    # Check if the header is displayed correctly
    expect(page).to have_css('div.flex.bg-main')
  end

  scenario 'User visits the edit transaction page and sees the heading' do
    # Check if the heading is displayed
    expect(page).to have_content('Edit Transaction')
  end

  scenario 'User visits the edit transaction page and sees the form' do
    # Check if the form is present
    expect(page).to have_selector('form')
  end

  scenario 'User visits the edit transaction page and sees pre-filled form fields' do
    # Check if the form fields are pre-filled with transaction details
    expect(find_field('Name').value).to eq(transaction.name)
    expect(find_field('Amount').value).to eq(transaction.amount.to_s)
  end
end
