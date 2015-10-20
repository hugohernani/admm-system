require 'rails_helper'

module Blog
  RSpec.describe BloggersController, type: :controller do
    render_views

    let(:valid_attributes) { attributes_for(:blogger) }
    let(:invalid_attributes) { attributes_for(:invalid_blogger) }

    describe 'GET #new' do
      it 'assigns a new blogger as @blogger' do
        get :new
        expect(assigns(:blogger)).to be_a_new(Blogger)
      end
    end

    describe 'POST #create' do
      context 'when success' do
        it 'create a new blogger' do
          expect do
            post :create, blog_blogger: valid_attributes
          end.to change(Blogger, :count).by(1)
        end

        it 'assigns a newly created blogger as @blogger' do
          post :create, blog_blogger: valid_attributes

          expect(assigns(:blogger)).to be_a(Blogger)
          expect(assigns(:blogger)).to be_persisted
        end
      end

      context 'when fail' do
        it 'assigns a newly created but unsaved blogger as @blogger' do
          post :create, blog_blogger: invalid_attributes

          expect(assigns(:blogger)).to be_a_new(Blogger)
        end

        it "re-renders the 'new' template" do
          post :create, blog_blogger: invalid_attributes

          expect(response).to render_template(:new)
        end
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested blogger as @blogger' do
        blogger = create :blogger, valid_attributes

        get :edit, id: blogger.to_param

        expect(assigns(:blogger)).to eq(blogger)
      end
    end

    describe 'PUT #update' do
      context 'when success' do
        let(:new_attributes) { { description: 'New description added for the blogger resource' } }

        it 'updates the requested blogger' do
          blogger = create :blogger, valid_attributes

          put :update, id: blogger.to_param, blog_blogger: new_attributes
          blogger.reload

          expect(blogger.description).to eq('New description added for the blogger resource')
        end

        it 'assigns the requested blogger as @blogger' do
          blogger = create :blogger, valid_attributes

          put :update, id: blogger.to_param, blog_blogger: valid_attributes

          expect(assigns(:blogger)).to eq(blogger)
        end
      end

      context 'when fail' do
        let!(:blogger) { create(:blogger, theme: 'New description added for the blogger resource') }

        it 'do not change information' do
          put :update, id: blogger.id, blog_blogger: { theme: nil }

          expect(blogger.theme).to eq('New description added for the blogger resource')
        end

        it 'render edit template' do
          put :update, id: blogger.id, blog_blogger: { theme: nil }

          expect(response).to render_template(:edit)
        end
      end
    end
  end
end
