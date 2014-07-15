class UsersController < ApplicationController
  load_and_authorize_resource param_method: :my_user_params

  def edit
  end

  def show
    @search = @user.myads.search(params[:q])
    @myads = @search.result.paginate(page: params[:page], per_page: 10)
  end

  def index
    @search = @users.search(params[:q])
    @users = @search.result.paginate(page: params[:page], per_page: 10)
  end

  def update
    respond_to do |format|
      if flash[:success] = @user.update(my_user_params)
        flash[:success] = 'User was successfully updated.'
        format.html { redirect_to @user }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
    end
  end

  private

  def my_user_params
    params.require(:user)
      .permit(:first_name, :last_name, :email, :role, :password)
  end
end
