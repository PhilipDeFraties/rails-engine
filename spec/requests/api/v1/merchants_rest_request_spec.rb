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

    it "can update an merchant" do
      id = create(:merchant).id
      previous_name = Merchant.last.name
      merchant_params = { name: "Globodyne" }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/merchants/#{id}", headers: headers, params: JSON.generate(merchant_params)
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(merchant).to have_key(:data)
      expect(merchant[:data]).to be_a(Hash)
      merchant_response_checker(merchant[:data])

      merchant = Merchant.find_by(id: id)
      expect(response).to be_successful
      expect(merchant.name).to_not eq(previous_name)
      expect(merchant.name).to eq("Globodyne")
    end
  end

  describe 'Merchant relationships endpoints' do
    it "can get items for a merchant" do
      merchant = create(:merchant)
      merchant_2 = create(:merchant)

      create_list(:item, 10, merchant_id: merchant.id)
      create_list(:item, 10, merchant_id: merchant_2.id)

      get "/api/v1/merchants/#{merchant.id}/items"

      merchant_items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(merchant_items).to have_key(:data)
      expect(merchant_items[:data]).to be_an(Array)
      expect(merchant_items[:data].count).to eq(10)
      expect(Item.all.count).to eq(20)

      merchant_items[:data].each do |item|
        item_response_checker(item)
      end
    end
  end
end
