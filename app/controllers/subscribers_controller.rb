# frozen_string_literal: true

require 'httparty'

class SubscribersController < ApplicationController
  before_action :set_subscriber, only: %i[show]

  # GET /subscribers or /subscribers.json
  def index
    @subscribers = Subscriber.all
  end

  # GET /subscribers/new
  def new
    @preferences = Preference.all
    @subscriber = Subscriber.new
  end

  # POST /subscribers or /subscribers.json
  def create
    @preferences = Preference.all
    @subscriber = Subscriber.new(email: subscriber_params['email'])

    @preferences.each do |preference|
      @subscriber.preferences << preference if subscriber_params[preference.name].eql?('1')
    end

    if @subscriber.save 
      ConfirmationMailer.subscription(@subscriber).deliver_now
      redirect_to subscribers_path, status: :created, notice: "We've sent you an email to confirm your subscription." 
    else
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
      params.require(:subscriber).permit(:email, :women, :men, :children)
    end

end
