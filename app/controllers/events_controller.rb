class EventsController < ApplicationController
  before_filter :authenticate_user!
  before_action :determine_scope
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = @scope.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = @scope.new
  end

  # GET /events/1/edit
  def edit
    @duration = @event.duration.strftime("%I:%M")
    @start_time = @event.start.strftime("%I:%M %p")
    @start_date = @event.start.strftime("%B %e, %Y")
    @end = @event.end.strftime("%B %e, %Y, %I:%M %p")
  end

  # POST /events
  # POST /events.json
  def create
    @event = @scope.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to ([@event.creator, @event]), notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to ([@event.creator, @event]), notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = @scope.find(params[:id])
    end

    def correct_user?
      is_admin? or current_user.id == params[:user_id]
    end

    def determine_scope
      @scope = if params[:user_id]
        (correct_user? ? User.find(params[:user_id]) : current_user).events
      else
        is_admin? ? Event : current_user.events
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      form = params[:event]
      if form[:start]
        date, time = form[:start_date], form[:start]
        form[:start] = (date + ' ' + time).to_datetime

        duration = form[:duration].to_time
        form[:end] = form[:start].advance({:hours => duration.hour, :minutes => duration.min})
        params[:event] = form
      end
      params.require(:event).permit(:title, :description, :start, :start_date, :duration,
                                    :creator_name, resource_ids: [], facility_ids: [])
    end

end
