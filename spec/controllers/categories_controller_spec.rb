require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    let!(:category) { create(:category, user:) }
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns @categories' do
      get :index
      expect(assigns(:categories)).to match_array([category])
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { id: category.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new category as @category' do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new category' do
        expect do
          post :create, params: { category: attributes_for(:category) }
        end.to change(Category, :count).by(1)
      end

      it 'redirects to categories path' do
        post :create, params: { category: attributes_for(:category) }
        expect(response).to redirect_to(categories_url)
      end
    end

    context 'with invalid params' do
      it 'renders the new template' do
        post :create, params: { category: attributes_for(:category, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: category.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested category' do
        put :update, params: { id: category.id, category: { name: 'Updated Name' } }
        expect(category.reload.name).to eq('Updated Name')
      end

      it 'redirects to categories path' do
        put :update, params: { id: category.id, category: { name: 'Updated Name' } }
        expect(response).to redirect_to(categories_url)
      end
    end

    context 'with invalid params' do
      it 'renders the edit template' do
        put :update, params: { id: category.id, category: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:category) { create(:category, user:) } # Use let! to create it before the test

    it 'destroys the requested category' do
      expect do
        delete :destroy, params: { id: category.id }
      end.to change(Category, :count).by(-1)

      expect(response).to redirect_to(categories_url)
    end
  end
end
