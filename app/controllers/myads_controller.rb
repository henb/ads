class MyadsController < ApplicationController
  respond_to :html, only: [:create, :update]
  respond_to :js, only: :update_all_state
  load_and_authorize_resource param_method: :myad_params
  before_action :gget_type, only: [:new, :create, :edit, :update]

  def index
    @search = @myads.search(params[:q])
    @myads = @search.result.paginate(page: params[:page], per_page: params[:per_page])
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @myad.user = current_user
    flash[:success] = 'Myad was successfully created.' if @myad.save
    respond_with @myad
  end

  def update
    flash[:success] = 'Myad was successfully updated.' if @myad.update(myad_params)
    respond_with @myad
  end

  def destroy
    @myad.destroy
    respond_with do |format|
      format.html { redirect_to myads_path }
      format.js
    end
  end

  # change events
  def self.attr_event(*events)
    events.each do |event|
      define_method("#{event}") do
        @myad.send(event)
        respond_with do |format|
          format.html { redirect_to myad_path(@myad, event: true) }
          format.js   { render 'event' }
        end
      end
    end
  end

  attr_event *Myad.state_machine.events.map(&:name)

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
  end

  private

  def gget_type
    @typeads = Typead.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def myad_params
    params.require(:myad).permit(:title, :description, :typead_id, images_attributes: [:id, :url, :_destroy])
  end
end
