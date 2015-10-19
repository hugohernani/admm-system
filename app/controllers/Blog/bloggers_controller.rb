module Blog
  class BloggersController < ApplicationController
    before_action :set_blogger, only: [:show, :edit, :update, :destroy]

    def index
      @bloggers = Blogger.all
    end

    def show
    end

    def new
      @blogger = current_user.bloggers.build
    end

    def edit
    end

    def create
      @blogger = current_user.bloggers.build(blogger_params)
      flash[:notice] = 'Blogger was successfully created.' if @blogger.save

      respond_with @blogger, location: @blogger
    end

    def update
      @blogger.update(blogger_params)
      flash[:notice] = 'Blogger was successfully updated.'
      respond_with @blogger, location: bloggers_path(@blogger)
    end

    def destroy
      @blogger.destroy
      flash[:notice] = 'Blogger was successfully destroyed.'
      respond_with @blogger
    end

    private
      def set_blogger
        @blogger = Blogger.find(params[:id])
      end

      def blogger_params
        params.require(:blogger).permit(:theme, :description, :user_id)
      end
  end
end
