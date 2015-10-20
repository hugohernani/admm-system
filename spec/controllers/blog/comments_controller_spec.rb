require 'rails_helper'

module Blog
  RSpec.describe CommentsController, type: :controller do
    render_views

    let(:valid_attributes) { attributes_for(:blog_comment) }
    let(:invalid_attributes) { attributes_for(:invalid_blog_comment) }

    before(:all) do
      @post = create(:blog_post, user: current_user)
    end

    describe 'POST #create' do
      context 'when success' do
        it 'create a new comment' do
          expect do
            post :create, post_id: @post.to_param, blog_comment: valid_attributes
          end.to change(Comment, :count).by(1)
        end

        it 'assigns a newly created comment as @comment' do
          post :create, post_id: @post.to_param, blog_comment: valid_attributes

          expect(assigns(:comment)).to be_a(Comment)
          expect(assigns(:comment)).to be_persisted
        end
      end
    end
  end
end
