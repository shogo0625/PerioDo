require 'rails_helper'

RSpec.describe "Routines", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/routines/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/routines/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/routines/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/routines/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
