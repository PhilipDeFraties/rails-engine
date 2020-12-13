require 'rails_helper'

describe "Merchants API" do
  describe "CRUD Endpoints" do
    it "can get one merchant by its id" do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(merchant).to have_key(:data)
      expect(merchant[:data]).to be_a(Hash)

      merchant_response_checker(merchant)
    end
  end
end
