require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { create(:user) }
  let(:category) { build(:category, user:) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_and_belong_to_many(:financial_transactions).class_name('Transaction') }
    it { should have_one_attached(:icon) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should allow_value('Category1').for(:name) }
    it { should_not allow_value('Category@').for(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id) }

    it 'does not allow reserved names' do
      %w[admin user guest].each do |reserved_name|
        category.name = reserved_name
        expect(category).not_to be_valid
        expect(category.errors[:name]).to include('is reserved')
      end
    end
  end
end