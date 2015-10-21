require_dependency 'blog_controller'

class PostsController < BlogApplication
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy,
                                        :toggle_comments, :toggle_activation]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new({status: ::CommonStatus::ACTIVE})
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.attributes = {
      status: ::CommonStatus::ACTIVE}
    @post.save

    respond_with @post, location: blog_posts_path(@post)
  end

  def update
    @post.update(blog_post_params)

    respond_with @post, location: blog_posts_path(@post)
  end

  def destroy
    @post.destroy
    redirect_to blog_posts_path
  end

  def toggle_activation
    new_status = define_new_status @post
    comment_allowed = new_status == CommonStatus::ACTIVE ? true : false
    @post.update_attributes({status: new_status, comment_allowed: comment_allowed})

    redirect_to blog_posts_path
  end

  def toggle_comments
    @post.update_attributes({comment_allowed: !@post.comment_allowed})

    redirect_to blog_posts_path
  end

  private
    def set_blog_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :description, :body, :status, :blogger_id, :comment_allowed)
    end

    def define_new_status(post)
      if post.status == CommonStatus::ACTIVE
        CommonStatus::INACTIVE
      else
        CommonStatus::ACTIVE
      end
    end
end
