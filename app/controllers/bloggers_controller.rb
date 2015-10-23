require_dependency 'blog_controller'

class BloggersController < BlogApplication
  load_and_authorize_resource

  def index
    @bloggers = Blogger.all
  end

  def show
  end

  def new
    @blogger = Blogger.new({user_id: current_user.id, status: ::CommonStatus::ACTIVE})
  end

  def edit
  end

  def create
    @blogger.attributes = {user_id: current_user.id, status: ::CommonStatus::ACTIVE}
    respond_with @blogger, location: blog_bloggers_path(@blogger)
  end

  def update
    @blogger.update(blogger_params)
    respond_with @blogger, location: blog_bloggers_path(@blogger)
  end

  def destroy
    @blogger.destroy
    redirect to blog_bloggers_path
  end

  private
    def blogger_params
      params.require(:blogger).permit(:theme, :description)
    end
end
