require_dependency 'blog_controller'

class CommentsController < BlogApplication
  before_action :set_post, only: [:create, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.attributes = {post: @post, user: current_user}
    @comment.save

    respond_with @comment, location: blog_posts_path(@post)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to blog_post_path(@post)
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:title, :content, :post_id)
    end
end
