require 'rails_helper'

describe "Items API" do
  describe "CRUD Endpoints" do
    it "can get one item by its id" do
      id = create(:item).id

      get "/api/v1/items/#{id}"

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(item).to have_key(:data)
      expect(item[:data]).to be_a(Hash)

      item_response_checker(item[:data])
    end

    it "sends a list of items" do
      create_list(:item, 3)

      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(3)

      expect(items).to have_key(:data)
      expect(items[:data]).to be_an(Array)

      items[:data].each do |item|
        item_response_checker(item)
      end
    end

    it "can create a new item" do
      merchant_id = create(:merchant).id
      item_params = ({
                      name: 'Kick Pants',
                      description: 'Pants for kicking',
                      unit_price: 3000.00,
                      merchant_id: merchant_id
                    })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item_params)

      created_item = Item.last

      expect(response).to be_successful
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(item).to have_key(:data)
      expect(item[:data]).to be_a(Hash)

      item_response_checker(item[:data])
    end

    it "can delete an item" do
      item = create(:item)

      expect(Item.count).to eq(1)

      delete "/api/v1/items/#{item.id}"

      expect(response).to be_successful
      expect(Item.count).to eq(0)
      expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "can update an item" do
      id = create(:item).id
      previous_name = Item.last.name
      item_params = { name: "Kick Pants" }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item_params)
      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq(item_params[:name])

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(item).to have_key(:data)
      expect(item[:data]).to be_a(Hash)

      item_response_checker(item[:data])
    end
  end

  describe 'Items relationships endpoints' do
    it "can get merchant for item" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/#{item.id}/merchants"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(merchant).to have_key(:data)
      expect(merchant[:data]).to be_an(Hash)

      merchant_response_checker(merchant[:data])
    end
  end

  describe 'Items search endpoints' do
    it "can return a list of items with names matching a search" do
      item_names = ["Thing 1", "Thing 2", "Thing 3", "Name"]

      item_names.each do |name|
        create(:item, name: name)
      end

      get '/api/v1/items/find_all?name=ing'

      items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(items).to have_key(:data)
      expect(items[:data]).to be_an(Array)
      expect(Item.all.count).to eq(4)
      expect(items[:data].count).to eq(3)

      items[:data].each do |item|
        item_response_checker(item)
      end
    end

    it "can return a list of items with descriptions matching a search" do
      item_descriptions = ["first cool item", "second cool item", "third cool item", "meh"]

      item_descriptions.each do |description|
        create(:item, description: description)
      end
  
      get '/api/v1/items/find_all?description=cool'

      items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(items).to have_key(:data)
      expect(items[:data]).to be_an(Array)
      expect(Item.all.count).to eq(4)
      expect(items[:data].count).to eq(3)

      items[:data].each do |item|
        item_response_checker(item)
      end
    end
  end
end
