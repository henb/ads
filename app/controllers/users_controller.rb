class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit,:destroy,:update]
  before_action :set_search, only: :show

  def edit
  end

  def show
    @search = Myad.search(params[:q])
    @myads = @search.result.paginate(page: params[:page], per_page: 10)
  end
  
  def index
    @search = User.search(params[:q])
    @users = @search.result.paginate(page: params[:page], per_page: 10)
  end


  def update
    respond_to do |format|
      if @user.update(my_user_params)
        flash[:success] = 'User was successfully updated.'
        format.html { redirect_to @user }
        format.json { head :no_content }
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
    def set_user
      @user = User.find(params[:id])
    end

    def set_search
      params[:q] ||= {}
      params[:q][:user_id_eq] = params[:id]  if params[:id]

      if admin?
          params[:q][:state_in] = Myad.admin_state
      else
          params[:q][:state_eq] = states_ad.index(:published)
      end
    end

    def my_user_params
      params.require(:user)
        .permit(:first_name,:last_name, :email, :role,:password)
    end
end