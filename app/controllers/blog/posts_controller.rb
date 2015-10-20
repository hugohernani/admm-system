require_dependency 'application_controller'
require 'pry'

module Blog
  class PostsController < ApplicationController
    before_action :set_blog_post, only: [:show, :edit, :update, :destroy,
                                          :toggle_comments, :toggle_activation]
    before_action :authenticate_user!, except: [:index, :show]
    respond_to :html

    def index
      @posts = Post.all
    end

    def show
    end

    def new
      @post = Post.new({user_id: current_user.id, status: ::CommonStatus::ACTIVE})
    end

    def edit
    end

    def create
      @post = Post.new(blog_post_params)
      @post.attributes = {
        user_id: current_user.id,
        status: ::CommonStatus::ACTIVE,
        can_comment: true}
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
      can_comment = new_status == CommonStatus::ACTIVE ? true : false
      @post.update_attributes({status: new_status, can_comment: can_comment})

      redirect_to blog_posts_path
    end

    def toggle_comments
      @post.update_attributes({can_comment: !@post.can_comment})

      redirect_to blog_posts_path
    end

    private
      def set_blog_post
        @post = Post.find(params[:id])
      end

      def blog_post_params
        params.require(:blog_post).permit(:title, :description, :body, :status)
      end

      def define_new_status(post)
        if post.status == CommonStatus::ACTIVE
          CommonStatus::INACTIVE
        else
          CommonStatus::ACTIVE
        end
      end
  end
end
