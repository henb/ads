class TypeadsController < ApplicationController
  respond_to :html, only: [:create]
  load_and_authorize_resource param_method: :typead_params
  def index
  end

  def show
    @search = @typead.myads.search(params[:q])
    @myads = @search.result.including.paginate(page: params[:page], per_page: 10)
  end

  def new
  end

  def create
    flash[:success] = 'Typead was successfully created.' if @typead.save
    respond_with @typead
  end

  def destroy
    if @typead.destroy
      redirect_to typeads_url
      flash[:success] = 'Typead was successfully deleted.'
    else
      redirect_to @typead
      flash[:danger] = 'Typead not empty!'
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def typead_params
    params.require(:typead).permit(:name, :description)
  end
end
