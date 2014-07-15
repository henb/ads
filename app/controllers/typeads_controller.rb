class TypeadsController < ApplicationController
  load_and_authorize_resource param_method: :typead_params

  def index
  end

  def show
    @search = @typead.myads.search(params[:q])
    @myads = @search.result.paginate(page: params[:page], per_page: 10)
  end

  def new
  end

  def create
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
