class TypeadsController < ApplicationController
  load_and_authorize_resource
  before_action :set_typead, only: [:show, :destroy]

  # GET /typeads
  # GET /typeads.json
  def index
    @typeads = Typead.all
  end

  # GET /typeads/1
  # GET /typeads/1.json
  def show
    @ads = @typead.myads.where(state:states_ad.index(:published)).paginate(page: params[:page], per_page: 3)
  end

  # GET /typeads/new
  def new
    @typead = Typead.new
  end

  # POST /typeads
  # POST /typeads.json
  def create
    @typead = Typead.new(typead_params)

    respond_to do |format|
      if @typead.save
        format.html { redirect_to @typead, notice: 'Typead was successfully created.' }
        format.json { render action: 'show', status: :created, location: @typead }
      else
        format.html { render action: 'new' }
        format.json { render json: @typead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /typeads/1
  # DELETE /typeads/1.json
  def destroy
    respond_to do |format|
      if @typead.myads.size.zero?
        @typead.destroy
        format.html { redirect_to typeads_url }
        format.json { head :no_content }
      else
        format.html { redirect_to @typead, notice: 'Typead not empty!' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_typead
      @typead = Typead.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def typead_params
      params.require(:typead).permit(:name, :description)
    end
end
