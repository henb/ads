class MyadsController < ApplicationController
  load_and_authorize_resource
  before_action :set_myad, only: [:show, :edit, :update, :destroy,:event]
  before_action :get_type, only: [:new,:create,:edit]
  before_action :params_hash_for_where, only: :index
  before_action :params_q_for_published, only: :published
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
        flash[:success] = 'Myad was successfully created.'
        format.html { redirect_to @myad }
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
        flash[:success] = 'Myad was successfully updated.'
        format.html { redirect_to @myad }
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

    if @myad.state_paths.events.include? event   
      @myad.send(event)
    end

    respond_to do |format|
      format.html { redirect_to myad_path(@myad) }
      format.js 
    end
    
  end
  
  def published
    @search = Myad.search(params[:q])
    @myads = @search.result.paginate(page: params[:page], per_page: 10)
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

      if admin?
        @hash_where[:state] = states_ad.index(params[:state].to_sym) if params[:state]
        return nil
      end

      @hash_where[:state] = states_ad.index(params[:state].to_sym) if params[:state]
      @hash_where[:user] = current_user if current_user

    end

    def params_q_for_published
     params[:q] ||= {} 
        if admin?
          params[:q][:state_in] = Myad.admin_state
        else
          params[:q][:state_eq] = states_ad.index(:published)
        end
    end
end
