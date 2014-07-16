class UsersController < ApplicationController
  respond_to :html, only: [:update]
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
    flash[:success] = 'User was successfully updated.' if flash[:success] = @user.update(my_user_params)
    respond_with @user
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def my_user_params
    params.require(:user)
      .permit(:first_name, :last_name, :email, :role, :password)
  end
end
