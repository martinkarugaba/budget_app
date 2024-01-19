require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'GET #index' do
    it 'assigns all transactions as @transactions' do
      transaction = create(:transaction)
      get :index
      expect(assigns(:transactions)).to eq([transaction])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested transaction as @transaction' do
      transaction = create(:transaction)
      get :show, params: { id: transaction.to_param }
      expect(assigns(:transaction)).to eq(transaction)
    end
  end

  describe 'GET #new' do
    it 'assigns a new transaction as @transaction' do
      get :new
      expect(assigns(:transaction)).to be_a_new(Transaction)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested transaction as @transaction' do
      transaction = create(:transaction)
      get :edit, params: { id: transaction.to_param }
      expect(assigns(:transaction)).to eq(transaction)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Transaction' do
        expect do
          post :create, params: { transaction: attributes_for(:transaction) }
        end.to change(Transaction, :count).by(1)
      end

      it 'assigns a newly created transaction as @transaction' do
        post :create, params: { transaction: attributes_for(:transaction) }
        expect(assigns(:transaction)).to be_a(Transaction)
        expect(assigns(:transaction)).to be_persisted
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved transaction as @transaction' do
        post :create, params: { transaction: attributes_for(:transaction, name: '') }
        expect(assigns(:transaction)).to be_a_new(Transaction)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Updated Transaction' } }

      it 'updates the requested transaction' do
        transaction = create(:transaction)
        put :update, params: { id: transaction.to_param, transaction: new_attributes }
        transaction.reload
        expect(transaction.name).to eq('Updated Transaction')
      end
    end

    context 'with invalid params' do
      it 'assigns the transaction as @transaction' do
        transaction = create(:transaction)
        put :update, params: { id: transaction.to_param, transaction: attributes_for(:transaction, name: '') }
        expect(assigns(:transaction)).to eq(transaction)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested transaction' do
      transaction = create(:transaction)
      expect do
        delete :destroy, params: { id: transaction.to_param }
      end.to change(Transaction, :count).by(-1)
    end
  end
end
