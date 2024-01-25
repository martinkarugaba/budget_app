# spec/models/category_spec.rb

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      expect(Category.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'has and belongs to many financial_transactions' do
      expect(Category.reflect_on_association(:financial_transactions).macro).to eq(:has_and_belongs_to_many)
      expect(Category.reflect_on_association(:financial_transactions).options[:class_name]).to eq('Transaction')
    end

    it 'has one attached icon' do
      expect(Category.new).to respond_to(:icon)
    end
  end

  describe 'validations' do
    it 'validates presence of name' do
      expect(Category.new).to validate_presence_of(:name)
    end

    it 'allows valid name' do
      expect(Category.new).to allow_value('Category1').for(:name)
    end

    it 'does not allow invalid name' do
      expect(Category.new).not_to allow_value('Category@').for(:name)
    end

    it 'validates uniqueness of name scoped to user_id' do
      user = create(:user)
      category = create(:category, user:)

      another_category = build(:category, name: category.name, user:)
      expect(another_category).not_to be_valid
      expect(another_category.errors[:name]).to include('has already been taken')
    end
  end

  describe 'custom validations' do
    it 'validates that name is not reserved' do
      category = build(:category, name: 'admin')
      category.valid?
      expect(category.errors[:name]).to include('is reserved')
    end
  end
end
