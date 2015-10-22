require_dependency 'blog_controller'

class CommentsController < BlogApplication
  load_and_authorize_resource

  def create
    @comment.attributes = {post: @post, user: current_user}
    @comment.save

    respond_with @comment, location: blog_post_path(@post)
  end

  def destroy
    @comment.destroy
    redirect_to blog_post_path(@post)
  end

  private
    def comment_params
      params.require(:comment).permit(:title, :content)
    end
end
