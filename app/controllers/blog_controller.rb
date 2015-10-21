require_dependency 'application_controller'

class BlogApplication < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  respond_to :html

  layout 'layouts/blog'

end
