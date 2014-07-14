class TypeadsController < ApplicationController
  load_and_authorize_resource param_method: :typead_params
  before_action :set_search, only: :show

  def index
    @typeads = Typead.all
  end

  def show
    @search = Myad.search(params[:q])
    @myads = @search.result.accessible_by(current_ability)
                            .paginate(page: params[:page], per_page: 10)
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
    @typead.destroy
    redirect_to typeads_url
  end

  private
  def set_search
    params[:q] ||= {}
    params[:q][:typead_id_eq] = params[:id]  if params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def typead_params
    params.require(:typead).permit(:name, :description)
  end
end
