class BlogApplication < ApplicationController
  respond_to :html
  before_action :authenticate_user!, except: [:index, :show]
end
