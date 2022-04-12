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
    @preferences = Preference.all
    @subscriber = Subscriber.new
    @preference = Preference.new
  end


  # POST /subscribers or /subscribers.json
  def create
    @preferences = Preference.all
    @subscriber = Subscriber.new(email: subscriber_params["email"])

    @preferences.each do |preference|
      @subscriber.preferences << preference if subscriber_params[preference.name] == "1"
    end

    if @subscriber.save 
      redirect_to subscriber_url(@subscriber), status: :created, notice: "Subscriber was successfully created." 
    else
      render :new, status: :unprocessable_entity 
    end

  end


  private
    # Only allow a list of trusted parameters through.
    def subscriber_params
      params.require(:subscriber).permit(:email, :women, :men,:children)
    end
end
