require_dependency 'application_controller'

module Blog
  class BloggersController < ApplicationController
    before_action :set_blogger, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    respond_to :html

    def index
      @bloggers = Blogger.all
    end

    def show
    end

    def new
      @blogger = Blogger.new({user_id: current_user.id})
    end

    def edit
    end

    def create
      @blogger = Blogger.new(blogger_params)
      @blogger.attributes = {user_id: current_user.id, status: ::CommonStatus::ACTIVE}
      flash[:notice] = 'Blogger was successfully created.' if @blogger.save

      respond_with @blogger, location: blog_bloggers_path(@blogger)
    end

    def update
      @blogger.update(blogger_params)
      flash[:notice] = 'Blogger was successfully updated.'
      respond_with @blogger, location: blog_bloggers_path(@blogger)
    end

    def destroy
      @blogger.destroy
      flash[:notice] = 'Blogger was successfully destroyed.'
      redirect to blog_bloggers_path
    end

    private
      def set_blogger
        @blogger = Blogger.find(params[:id])
      end

      def blogger_params
        params.require(:blog_blogger).permit(:theme, :description, :user_id)
      end
  end
end
