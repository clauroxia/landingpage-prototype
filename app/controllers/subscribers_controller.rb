class SubscribersController < ApplicationController
  before_action :set_subscriber, only: %i[ show edit update destroy ]

  # GET /subscribers or /subscribers.json
  def index
    @subscribers = Subscriber.all
  end

  # GET /subscribers/1 or /subscribers/1.json
  def show
  end

  # GET /subscribers/new
  def new
    @subscriber = Subscriber.new
    @preference = Preference.new
  end


  # POST /subscribers or /subscribers.json
  def create
    @subscriber = Subscriber.new(subscriber_params)
    @preference = Preference.new()
    if params.key?("women")
      p "######################################"
      p "######################################"
      pp params
      p "######################################"
      p "######################################"
      @preference.women = true
    end
    if params.key?("men") 
      p "######################################"
      p "######################################"
      pp params
      p "######################################"
      p "######################################"
      @preference.men = true
    end
    if params.key?("children")
      p "######################################"
      p "######################################"
      pp params
      p "######################################"
      p "######################################"
      @preference.children = true
    end

    respond_to do |format|
      if @subscriber.save 
        @preference.subscriber = @subscriber
        if @preference.save
          format.html { redirect_to subscriber_url(@subscriber), notice: "Subscriber was successfully created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscriber
      @subscriber = Subscriber.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subscriber_params
      params.require(:subscriber).permit(:email, :preferences)
    end
end
