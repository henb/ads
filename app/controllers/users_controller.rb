class UsersController < ApplicationController
  load_and_authorize_resource param_method: :my_user_params
  before_action :set_search, only: :show

  def edit
  end

  def show
    @search = Myad.search(params[:q])
    @myads = @search.result.accessible_by(current_ability)
                            .paginate(page: params[:page], per_page: 10)
  end

  def index
    @search = User.search(params[:q])
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
  def set_search
    params[:q] ||= {}
    params[:q][:user_id_eq] = params[:id]  if params[:id]
  end

  def my_user_params
    params.require(:user)
      .permit(:first_name, :last_name, :email, :role, :password)
  end
end
