class TypeadsController < ApplicationController
  load_and_authorize_resource
  before_action :set_search, only: :show

  def index
    @typeads = Typead.all
  end

  def show
    @search = Myad.search(params[:q])
    @myads = @search.result.paginate(page: params[:page], per_page: 10)
  end

  def new
    @typead = Typead.new
  end

  def create
    @typead = Typead.new(typead_params)

    respond_to do |format|
      if @typead.save
        flash[:success] = 'Typead was successfully created.'
        format.html { redirect_to @typead }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @typead.myads.size.zero?
        @typead.destroy
        format.html { redirect_to typeads_url }
      else
        flash[:danger] = 'Typead not empty!'
        format.html { redirect_to @typead }
      end
    end
  end

  private
  def set_search
    params[:q] ||= {}
    params[:q][:typead_id_eq] = params[:id]  if params[:id]

    if current_user
      if admin?
        params[:q][:state_in_or] = Myad.admin_state
      else
        params[:q][:g] = []
        params[:q][:g][0] = {}
        params[:q][:g][0][:user_id_eq] = current_user.id
        params[:q][:g][0][:m] = 'or'
        params[:q][:g][0][:state_eq] = states_ad.index(:published)
      end
    else
      params[:q][:state_eq] = states_ad.index(:published)
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def typead_params
    params.require(:typead).permit(:name, :description)
  end
end
