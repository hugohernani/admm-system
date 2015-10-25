require_dependency 'blog_controller'

class PostsController < BlogApplication
  load_and_authorize_resource
  before_action :is_blogger, only: [:new, :edit, :update, :create, :destroy,
                                    :toggle_comments, :toggle_activation]

  def index
    @posts = params && params[:query] ? Post.search(params[:query]) : Post.all
    @posts = params && !params[:blogger_id].blank? ? @posts.by_blogger(params[:blogger_id]) : @posts
  end

  def show
    respond_with(@post)
  end

  def new
    respond_with(@post = Post.new({status: ::CommonStatus::ACTIVE}))
  end

  def edit
  end

  def create
    @post.save
    respond_with @post, location: blog_posts_path
  end

  def update
    @post.update(post_params)
    respond_with @post, location: blog_post_path(@post)
  end

  def destroy
    @post.destroy
    respond_with @post
  end

  def toggle_activation
    new_status = define_new_status @post
    comment_allowed = new_status == CommonStatus::ACTIVE ? true : false
    @post.update_attributes({status: new_status, comment_allowed: comment_allowed})
    redirect_to :back
  end

  def toggle_comments
    @post.update_attributes({comment_allowed: !@post.comment_allowed})
    redirect_to :back
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :body, :status, :blogger_id, :comment_allowed)
  end

  def is_blogger
    if current_user.blogger.nil?
      redirect_to blog_posts_path
    end
  end

  def define_new_status(post)
    if post.status == CommonStatus::ACTIVE
      CommonStatus::INACTIVE
    else
      CommonStatus::ACTIVE
    end
  end
end
