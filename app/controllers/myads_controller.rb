class MyadsController < ApplicationController
  before_action :set_myad, only: [:show,   :edit,  :update, :destroy, :state,
                                  :fresh,  :reject,:fresh,  :approve, :publish,
                                  :archive,:ban,   :draft]  
  before_action :get_type, only: [:new,:create,:edit]

  include EventsForMyad
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
  
  #events myads
  # def state
  #   event = params[:event].to_s.to_sym
  #   if @myad.state_paths.events.include? event
  #       @myad.send(event)
  #   end
    
  #   respond_to do |format|
  #     format.html { redirect_to myads_path }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_myad
      @myad = Myad.find(params[:id])
    end

    def get_type
        @typeads = Typead.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def myad_params
      params.require(:myad).permit(:title, :description,:typead_id)
    end
end
