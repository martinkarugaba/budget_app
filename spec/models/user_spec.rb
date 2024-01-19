require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    describe 'validations' do
      it 'has a valid factory' do
        user = build(:user)
        expect(user).to be_valid
      end

      it 'validates presence of name' do
        user = build(:user, name: nil)
        expect(user).not_to be_valid
      end
    end

    describe 'associations' do
      it { should have_many(:categories) }
      it { should have_many(:transactions).with_foreign_key('author_id') }
    end

    describe 'devise modules' do
      it { should have_db_column(:email).of_type(:string).with_options(null: false, default: '') }
      it { should have_db_column(:encrypted_password).of_type(:string).with_options(null: false, default: '') }
      it { should have_db_index(:email).unique }
      it { should have_db_index(:reset_password_token).unique }
    end
  end
end
