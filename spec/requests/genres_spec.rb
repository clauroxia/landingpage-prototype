require 'rails_helper'

describe 'Subscribers', :type => :request do
  describe 'new path' do
    it 'respond with http success status code' do
      get '/subscribers/new'
      expect(response).to have_http_status(:ok)
    end
  end
end