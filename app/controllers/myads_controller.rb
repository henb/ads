class MyadsController < ApplicationController
  load_and_authorize_resource
  before_action :set_myad, only: [:show, :edit, :update, :destroy, :event]
  before_action :gget_type, only: [:new, :create, :edit]
  before_action :params_hash_for_where, only: :index
  before_action :params_q_for_published, only: :published
  # GET /myads
  # GET /myads.json

  def index
    @search = Myad.search(params[:q])
    @myads = @search.result.paginate(page: params[:page], per_page: 10)
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
      else
        format.html { render action: 'new' }
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
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /myads/1
  # DELETE /myads/1.json
  def destroy
    @myad.destroy
    respond_to do |format|
      format.html { redirect_to myads_url }
      format.js
    end
  end

  def event
    event = params[:event].to_sym
    @myad.send(event) if @myad.state_paths.events.include? event

    respond_to do |format|
      format.html { redirect_to myad_path(@myad, event: true) }
      format.js
    end
  end

  def published
    @search = Myad.search(params[:q])
    @myads = @search.result.paginate(page: params[:page], per_page: 10)
  end

  def update_all_state
    myad_ids = params[:myad_ids]
    event = params[:event].to_sym
    @flash = {}
    return @flash[:danger] = 'You are not authorized to access this page.' unless events_valid?(event)
    if myad_ids && event

      myads = Myad.find(params[:myad_ids])

      @event_myads = []
      myads.each do |myad|
        next if myad.state_events.include? event
        @event_myads.push myad
        myad.send event
      end

      @flash[:success] = "#{@event_myads.size} ads was successfully updated."
    else
      @flash[:danger] = 'Select an Ad!'
    end

    respond_to do |format|
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_myad
    @myad = Myad.find(params[:id])
  end

  def gget_type
    @typeads = Typead.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def myad_params
    params.require(:myad).permit(:title, :description, :typead_id, images_attributes: [:id, :url, :_destroy])
  end

  def params_hash_for_where
    params[:q] ||= {}
    if admin?
      if params[:state]
        params[:q][:state_eq] = states_ad.index(params[:state].to_sym)
      else
        params[:q][:state_in] = Myad.admin_state
      end
      return nil
    end

    params[:q][:state_eq] = states_ad.index(params[:state].to_sym) if params[:state]
    params[:q][:user_id_eq] = current_user.id if current_user
  end

  def params_q_for_published
    params[:q] ||= {}
    if current_user
      if current_user.admin?
        params[:q][:state_in] = Myad.admin_state
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
end
