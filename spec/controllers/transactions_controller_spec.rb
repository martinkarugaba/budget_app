# spec/controllers/transactions_controller_spec.rb

require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { create(:user) } # Assuming you have a User model and FactoryBot configured

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns @transactions' do
      transaction = create(:transaction)
      get :index
      expect(assigns(:transactions)).to eq([transaction])
    end
  end

  describe 'GET #show' do
    let(:transaction) { create(:transaction) }

    it 'renders the show template' do
      get :show, params: { id: transaction.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new transaction as @transaction' do
      get :new
      expect(assigns(:transaction)).to be_a_new(Transaction)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:category) { create(:category) } # Assuming you have a Category factory

      it 'creates a new transaction' do
        expect do
          post :create, params: { transaction: attributes_for(:transaction, category_ids: [category.id]) }
        end.to change(Transaction, :count).by(1)
      end

      it 'redirects to the category of the created transaction' do
        post :create, params: { transaction: attributes_for(:transaction, category_ids: [category.id]) }
        expect(response).to redirect_to(category_path(category))
      end

      it 'redirects to transactions path if no category is associated' do
        post :create, params: { transaction: attributes_for(:transaction) }
        expect(response).to redirect_to(transactions_path)
      end
    end

    context 'with invalid params' do
      it 'renders the new template' do
        post :create, params: { transaction: attributes_for(:transaction, name: nil) }
        expect(response).to redirect_to(transactions_path)
      end
    end
  end

  describe 'GET #edit' do
    let(:transaction) { create(:transaction) }

    it 'renders the edit template' do
      get :edit, params: { id: transaction.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    let(:transaction) { create(:transaction) }

    context 'with valid params' do
      it 'updates the requested transaction' do
        put :update, params: { id: transaction.id, transaction: { name: 'Updated Name' } }
        expect(transaction.reload.name).to eq('Updated Name')
      end
    end

    context 'with invalid params' do
      it 'renders the edit template' do
        put :update, params: { id: transaction.id, transaction: { name: nil } }
        expect(response).to redirect_to(category_path(transaction.categories.first))
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:transaction) { create(:transaction) }

    it 'destroys the requested transaction' do
      expect do
        delete :destroy, params: { id: transaction.id }
      end.to change(Transaction, :count).by(-1)
    end
  end
end
