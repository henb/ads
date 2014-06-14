class TypeadsController < ApplicationController
  before_action :set_typead, only: [:show, :edit, :update, :destroy]

  # GET /typeads
  # GET /typeads.json
  def index
    @typeads = Typead.all
  end

  # GET /typeads/1
  # GET /typeads/1.json
  def show
  end

  # GET /typeads/new
  def new
    @typead = Typead.new
  end

  # GET /typeads/1/edit
  def edit
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

  # PATCH/PUT /typeads/1
  # PATCH/PUT /typeads/1.json
  def update
    respond_to do |format|
      if @typead.update(typead_params)
        format.html { redirect_to @typead, notice: 'Typead was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @typead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /typeads/1
  # DELETE /typeads/1.json
  def destroy
    @typead.destroy
    respond_to do |format|
      format.html { redirect_to typeads_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_typead
      @typead = Typead.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def typead_params
      params.require(:typead).permit(:name, :text)
    end
end
