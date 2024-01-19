require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:valid_attributes) { FactoryBot.attributes_for(:category) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:category, name: nil) }
  let(:valid_session) { { user_id: user.id } }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      category = FactoryBot.create(:category)
      get :show, params: { id: category.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      category = FactoryBot.create(:category)
      get :edit, params: { id: category.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Category' do
        expect do
          post :create, params: { category: valid_attributes }, session: valid_session
        end.to change(Category, :count).by(1)
      end

      it 'assigns a newly created category as @category' do
        post :create, params: { category: valid_attributes }, session: valid_session
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end

      it 'redirects to the categories index' do
        post :create, params: { category: valid_attributes }, session: valid_session
        expect(response).to redirect_to(categories_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Category' do
        expect do
          post :create, params: { category: invalid_attributes }, session: valid_session
        end.to change(Category, :count).by(0)
      end

      it 'assigns a newly created but unsaved category as @category' do
        post :create, params: { category: invalid_attributes }, session: valid_session
        expect(assigns(:category)).to be_a_new(Category)
      end

      it 're-renders the new template' do
        post :create, params: { category: invalid_attributes }, session: valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:new_attributes) { FactoryBot.attributes_for(:category, name: 'New Name') }

      it 'updates the requested category' do
        category = FactoryBot.create(:category)
        put :update, params: { id: category.to_param, category: new_attributes }, session: valid_session
        category.reload
        expect(category.name).to eq('New Name')
      end

      it 'assigns the requested category as @category' do
        category = FactoryBot.create(:category)
        put :update, params: { id: category.to_param, category: valid_attributes }, session: valid_session
        expect(assigns(:category)).to eq(category)
      end

      it 'redirects to the categories index' do
        category = FactoryBot.create(:category)
        put :update, params: { id: category.to_param, category: valid_attributes }, session: valid_session
        expect(response).to redirect_to(categories_url)
      end
    end

    context 'with invalid parameters' do
      it 'assigns the category as @category' do
        category = FactoryBot.create(:category)
        put :update, params: { id: category.to_param, category: invalid_attributes }, session: valid_session
        expect(assigns(:category)).to eq(category)
      end

      it 're-renders the edit template' do
        category = FactoryBot.create(:category)
        put :update, params: { id: category.to_param, category: invalid_attributes }, session: valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested category' do
      category = FactoryBot.create(:category)
      expect do
        delete :destroy, params: { id: category.to_param }, session: valid_session
      end.to change(Category, :count).by(-1)
    end

    it 'redirects to the categories index' do
      category = FactoryBot.create(:category)
      delete :destroy, params: { id: category.to_param }, session: valid_session
      expect(response).to redirect_to(categories_url)
    end
  end
end
