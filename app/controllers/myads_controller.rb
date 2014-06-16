class MyadsController < ApplicationController
  load_and_authorize_resource
  before_action :set_myad, only: [:show, :edit, :update, :destroy,:event]
  before_action :get_type, only: [:new,:create,:edit]
  before_action :params_hash_for_where, only: :index
  # GET /myads
  # GET /myads.json

  def index
    @myads = Myad.where(@hash_where).paginate(page: params[:page], per_page: 10)
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

  # POST /myads.
  # POST /myads.json
  def create
    @myad = Myad.new(myad_params)
    @myad.user = current_user 

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

  def event
    event = params[:event].to_sym
    # if admin_events.include? event
    # if user_events.include? event

    if @myad.state_paths.events.include? event   
      @myad.send(event)
    end

    respond_to do |format|
      format.html { redirect_to @myad }
    end
  end


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

    def params_hash_for_where
      @hash_where = {}

      unless current_user
        @hash_where[:state] =  states_ad.index(:published)
        params[:published]=true
        return
      end 


      if current_user.role == "admin"
        @hash_where[:state] = states_ad.index(params[:state].to_sym) if params[:state]
        return nil
      end

      unless params[:published]
        @hash_where[:state] = states_ad.index(params[:state].to_sym) if params[:state]
        @hash_where[:user] = current_user if current_user
      else
        @hash_where[:state] =  states_ad.index(:published)
        params[:published] = true 
      end


    end
end
