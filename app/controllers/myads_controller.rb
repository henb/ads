class MyadsController < ApplicationController
  before_action :set_myad, only: [:show, :edit, :update, :destroy]

  # GET /myads
  # GET /myads.json
  def index
    @myads = Myad.all
  end

  # GET /myads/1
  # GET /myads/1.json
  def show
  end

  # GET /myads/new
  def new
    @myad = Myad.new
    @typeads = Typead.all
  end

  # GET /myads/1/edit
  def edit
  end

  # POST /myads
  # POST /myads.json
  def create
    @myad = Myad.new(myad_params)

    respond_to do |format|
      if @myad.save
        format.html { redirect_to @myad, notice: 'Myad was successfully created.' }
        format.json { render action: 'show', status: :created, location: @myad }
      else
        @typeads = Typead.all
        format.html { render action: 'new' }
        format.json { render json: @myad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /myads/1
  # PATCH/PUT /myads/1.json
  def update
    respond_to do |format|
      if @myad.update(myad_params)
        format.html { redirect_to @myad, notice: 'Myad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @myad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /myads/1
  # DELETE /myads/1.json
  def destroy
    @myad.destroy
    respond_to do |format|
      format.html { redirect_to myads_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_myad
      @myad = Myad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def myad_params
      params.require(:myad).permit(:title, :description,:typead_id)
    end
end
