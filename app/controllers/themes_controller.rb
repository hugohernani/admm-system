require_dependency 'blog_controller'

class ThemesController < BlogApplication
  load_and_authorize_resource

  def index
    @themes = Theme.all
    respond_with(@themes)
  end

  def show
    respond_with(@theme)
  end

  def new
    respond_with(Theme.new)
  end

  def edit
  end

  def create
    @theme.save
    respond_with(@theme)
  end

  def update
    @theme.update(theme_params)
    respond_with(@theme)
  end

  def destroy
    @theme.destroy
    respond_with(@theme)
  end

  private
    def theme_params
      params.require(:theme).permit(:title, :description, :blogger_id)
    end
end
