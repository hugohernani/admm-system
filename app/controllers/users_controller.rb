class UsersController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      sign_in(@user == current_user ? @user : current_user, :bypass => true)
    end
    respond_with @user
  end

  def finish_signup
    # authorize! :update, @user
    if request.patch? && params[:user] && params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to root_path, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  def destroy
    @user.destroy
    respond_with @user, location: root_path
  end

  private
    def user_params
      accessible = [ :name, :email, :status ]
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end
end
