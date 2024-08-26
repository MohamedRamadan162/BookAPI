require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "GET /list" do
    it "returns http success" do
      get "/books/list"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/books/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/books/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/books/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/books/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
