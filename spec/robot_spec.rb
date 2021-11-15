require 'pry'
require "rails_helper"

RSpec.describe "Robots", :type => :request do

  describe 'GET /robot/0/orders' do
    before do
      headers = { "ACCEPT" => "application/json" }
      get "/robot/0/orders", :params => { :command => ["PlACE 0,0,EAST", "MOVE", "MOVE", "LEFT", "MOVE", "REPORT"] }, :headers => headers
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected user attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response).to have_key("location")
    end
  end
end