module Blog
  class CommentsController < ApplicationController
    before_action :set_post, only: [:create, :destroy]
    before_action :authenticate_user!, except: [:show, :edit]
    respond_to :html

    def create
      @comment = Comment.new(comment_params)
      @comment.attributes = {post: @post, user: current_user}
      @comment.save

      respond_with @comment, location: blog_posts_path(@post)
    end

    def destroy
      @comment.destroy
      redirect_to blog_posts_path(@post)
    end

    private
      def set_post
        @post = Post.find(params[:post_id])
      end

      def comment_params
        params.require(:blog_comment).permit(:title, :content, :blog_post_id, :user_id)
      end
  end
end
