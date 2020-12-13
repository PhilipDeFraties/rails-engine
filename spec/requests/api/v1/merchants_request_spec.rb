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

      merchant_response_checker(merchant[:data])
    end

    it "sends a list of merchants" do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(3)

      expect(merchants).to have_key(:data)
      expect(merchants[:data]).to be_an(Array)

      merchants[:data].each do |merchant|
        merchant_response_checker(merchant)
      end
    end

    it "can create a new merchant" do
      merchant_params = ({  name: 'Globodyne' })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/merchants", headers: headers, params: JSON.generate(merchant_params)
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(merchant).to have_key(:data)
      expect(merchant[:data]).to be_a(Hash)
      merchant_response_checker(merchant[:data])

      merchant = Merchant.last
      expect(merchant.name).to eq(merchant_params[:name])
    end

    it "can delete an merchant" do
      merchant = create(:merchant)

      expect(Merchant.count).to eq(1)

      delete "/api/v1/merchants/#{merchant.id}"

      expect(response).to be_successful
      expect(Merchant.count).to eq(0)
      expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
