class MyadsController < ApplicationController
  load_and_authorize_resource param_method: :myad_params
  before_action :gget_type, only: [:new, :create, :edit]
  before_action :params_hash_for_where, only: :index

  def index
    @search = Myad.search(params[:q])
    @myads = @search.result.accessible_by(current_ability)
                          .paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @myad = Myad.new
  end

  def edit
  end

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

  def destroy
    @myad.destroy
    respond_to do |format|
      format.html { redirect_to myads_url }
      format.js
    end
  end

  # change events
  def draft
    @myad.draft
    respond_to do |format|
      format.html { redirect_to myad_path(@myad, event: true) }
      format.js   { render 'event' }
    end
  end

  def fresh
    @myad.fresh
    respond_to do |format|
      format.html { redirect_to myad_path(@myad, event: true) }
      format.js   { render 'event' }
    end
  end

  def reject
    @myad.reject
    respond_to do |format|
      format.html { redirect_to myad_path(@myad, event: true) }
      format.js   { render 'event' }
    end
  end

  def approve
    @myad.approve
    respond_to do |format|
      format.html { redirect_to myad_path(@myad, event: true) }
      format.js   { render 'event' }
    end
  end

  def publish
    @myad.publish
    respond_to do |format|
      format.html { redirect_to myad_path(@myad, event: true) }
      format.js   { render 'event' }
    end
  end

  def archive
    @myad.archive
    respond_to do |format|
      format.html { redirect_to myad_path(@myad, event: true) }
      format.js { render 'event' }
    end
  end

  def ban
    @myad.ban
    respond_to do |format|
      format.html { redirect_to myad_path(@myad, event: true) }
      format.js   { render 'event' }
    end
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
        next unless myad.state_events.include? event
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

  def gget_type
    @typeads = Typead.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def myad_params
    params.require(:myad).permit(:title, :description, :typead_id, images_attributes: [:id, :url, :_destroy])
  end

  def params_hash_for_where
    params[:q] ||= {}
    params[:q][:state_eq] = states_ad.index(params[:state].to_sym) if params[:state]
  end
end
