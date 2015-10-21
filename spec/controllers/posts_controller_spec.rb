require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:blogger) { create(:blogger) }

  let(:valid_attributes) { attributes_for(:post, blogger: blogger) }
  let(:invalid_attributes) { attributes_for(:invalid_post) }

  describe 'GET #new' do
    it 'assigns a new post as @post' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe 'POST #create' do
    context 'when success' do
      it 'create a new post' do
        expect do
          post :create, post: valid_attributes
        end.to change(Post, :count).by(1)
      end

      it 'assigns a newly created post as @post' do
        post :create, post: valid_attributes

        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:post)).to be_persisted
      end
    end

    context 'when fail' do
      it 'assigns a newly created but unsaved post as @post' do
        post :create, post: invalid_attributes

        expect(assigns(:post)).to be_a_new(Post)
      end

      it "re-renders the 'new' template" do
        post :create, post: invalid_attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested post as @post' do
      post = create :post, valid_attributes

      get :edit, id: post.to_param

      expect(assigns(:post)).to eq(post)
    end
  end

  describe 'PUT #update' do
    context 'when success' do
      let(:new_attributes) { { description: 'New description added for the post resource' } }

      it 'updates the requested post' do
        post = create :post, valid_attributes

        put :update, id: post.to_param, post: new_attributes

        expect(post.reload.description).to eq('New description added for the post resource')
      end

      it 'assigns the requested post as @post' do
        post = create :post, valid_attributes

        put :update, id: post.to_param, post: valid_attributes

        expect(assigns(:post)).to eq(post)
      end
    end

    context 'when fail' do
      let!(:post) { create(:post, title: 'New title added for the post resource', user: current_user) }

      it 'do not change information' do
        put :update, id: post.id, post: invalid_attributes

        expect(post.title).to eq('New title added for the post resource')
      end

      it 'render edit template' do
        put :update, id: post.to_param, post: invalid_attributes

        expect(response).to render_template(:edit)
      end
    end
  end
end
