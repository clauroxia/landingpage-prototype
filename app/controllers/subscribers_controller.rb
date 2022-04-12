require 'httparty'

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
      @preference.women = true
    end
    if params.key?("men") 
      @preference.men = true
    end
    if params.key?("children")
      @preference.children = true
    end

    response= HTTParty.get("https://emailvalidation.abstractapi.com/v1/?api_key=#{ENV["ABSTRACT_API_KEY"]}&email=#{subscriber_params[:email]}")

    p "######################################################################"
    p "######################################################################"
    pp response

    p "######################################################################"
    p "######################################################################"
    pp "#{ENV["BASE_URI_KEY"]}"
    p "######################################################################"
    p "######################################################################"
    
    if @subscriber.validate && (params.key?("men") || params.key?("women") || params.key?("children"))
      @subscriber.save
      @preference.subscriber = @subscriber
      @preference.save
      redirect_to subscriber_url(@subscriber), notice: "Subscriber was successfully created." 
    else
      if ((params.key?("men") || params.key?("women") || params.key?("children")))
        @preference.errors.add(:base, "You should choose at least one preference")
      end
      render :new, status: :unprocessable_entity 
    end

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscriber
      @subscriber = Subscriber.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subscriber_params
      params.require(:subscriber).permit(:email)
    end
end
