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
  end
end
