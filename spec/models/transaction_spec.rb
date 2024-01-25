require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_and_belong_to_many(:categories) }
  end

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe '#total_amount' do
    it 'returns the total amount of transactions' do
      user = create(:user)
      create(:transaction, author: user, amount: 10)
      create(:transaction, author: user, amount: 20)

      expect(Transaction.total_amount).to eq(30)
    end
  end

  describe '.recent' do
    it 'returns the most recent transactions' do
      old_transaction = create(:transaction, created_at: 1.week.ago)
      new_transaction = create(:transaction, created_at: 1.day.ago)

      expect(Transaction.recent).to eq([new_transaction, old_transaction])
    end
  end
end
