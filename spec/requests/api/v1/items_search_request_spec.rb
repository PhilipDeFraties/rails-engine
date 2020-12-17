require 'rails_helper'

describe "Items API" do
  describe 'Items search endpoints' do
    describe 'It can return a list of items' do
      it "with names partially matching a search query" do
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

      it "with names partially matching a search query, case insensitive" do
        item_names = ["Thing 1", "Thing 2", "Thing 3", "Name"]

        item_names.each do |name|
          create(:item, name: name)
        end

        get '/api/v1/items/find_all?name=ING'

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

      it "with descriptions partially matching a search" do
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

      it "with descriptions partially matching a search, case insensitive" do
        item_descriptions = ["first cool item", "second cool item", "third cool item", "meh"]

        item_descriptions.each do |description|
          create(:item, description: description)
        end

        get '/api/v1/items/find_all?description=COOL'

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

      it "with created timestamps matching a query" do
        item_1 = create(:item, created_at: 'Wed, 16 Dec 2020')
        item_2 = create(:item, created_at: 'Tue, 15 Dec 2020')
        item_3 = create(:item, created_at: 'Wed, 16 Dec 2020')
        item_4 = create(:item, created_at: 'Tue, 15 Dec 2020')

        get '/api/v1/items/find_all?created_at=December+16'

        items = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(items).to have_key(:data)
        expect(items[:data]).to be_an(Array)
        expect(Item.all.count).to eq(4)
        expect(items[:data].count).to eq(2)

        items[:data].each do |item|
          item_response_checker(item)
        end
        expect(items[:data][0][:id]).to eq(item_1.id.to_s)
        expect(items[:data][1][:id]).to eq(item_3.id.to_s)
      end

      it "with created timestamps matching a query, case insensitive" do
        item_1 = create(:item, created_at: 'Wed, 16 Dec 2020')
        item_2 = create(:item, created_at: 'Tue, 15 Dec 2020')
        item_3 = create(:item, created_at: 'Wed, 16 Dec 2020')
        item_4 = create(:item, created_at: 'Tue, 15 Dec 2020')

        get '/api/v1/items/find_all?created_at=DECEMBER+16'

        items = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(items).to have_key(:data)
        expect(items[:data]).to be_an(Array)
        expect(Item.all.count).to eq(4)
        expect(items[:data].count).to eq(2)

        items[:data].each do |item|
          item_response_checker(item)
        end
        expect(items[:data][0][:id]).to eq(item_1.id.to_s)
        expect(items[:data][1][:id]).to eq(item_3.id.to_s)
      end

      it "with updated timestamps matching a query" do
        item_1 = create(:item, updated_at: 'Wed, 16 Dec 2020')
        item_2 = create(:item, updated_at: 'Tue, 15 Dec 2020')
        item_3 = create(:item, updated_at: 'Wed, 16 Dec 2020')
        item_4 = create(:item, updated_at: 'Tue, 15 Dec 2020')

        get '/api/v1/items/find_all?updated_at=December+16'

        items = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(items).to have_key(:data)
        expect(items[:data]).to be_an(Array)
        expect(Item.all.count).to eq(4)
        expect(items[:data].count).to eq(2)

        items[:data].each do |item|
          item_response_checker(item)
        end
        expect(items[:data][0][:id]).to eq(item_1.id.to_s)
        expect(items[:data][1][:id]).to eq(item_3.id.to_s)
      end

      it "with updated timestamps partially matching query, case insensitive" do
        item_1 = create(:item, updated_at: 'Wed, 16 Dec 2020')
        item_2 = create(:item, updated_at: 'Tue, 15 Dec 2020')
        item_3 = create(:item, updated_at: 'Wed, 16 Dec 2020')
        item_4 = create(:item, updated_at: 'Tue, 15 Dec 2020')

        get '/api/v1/items/find_all?updated_at=DECEMBER+16'

        items = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(items).to have_key(:data)
        expect(items[:data]).to be_an(Array)
        expect(Item.all.count).to eq(4)
        expect(items[:data].count).to eq(2)

        items[:data].each do |item|
          item_response_checker(item)
        end
        expect(items[:data][0][:id]).to eq(item_1.id.to_s)
        expect(items[:data][1][:id]).to eq(item_3.id.to_s)
      end

      it "with unit price matching query" do
        items = [ create(:item, unit_price: 2.55),
                  create(:item, unit_price: 3.99),
                  create(:item, unit_price: 2.55),
                  create(:item, unit_price: 3.99) ]

        get '/api/v1/items/find_all?unit_price=2.55'

        items_response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(items_response).to have_key(:data)
        expect(items_response[:data]).to be_an(Array)
        expect(Item.all.count).to eq(4)
        expect(items_response[:data].count).to eq(2)

        items_response[:data].each do |item|
          item_response_checker(item)
        end
        expect(items_response[:data][0][:id]).to eq(items[0].id.to_s)
        expect(items_response[:data][1][:id]).to eq(items[2].id.to_s)
      end
    end

    describe "returns a single item" do
      it "with name matching a search" do
        items =  [ create(:item, name: "Thing 1"),
                   create(:item, name: "Thing 2"),
                   create(:item, name: "Name 1"),
                   create(:item, name: "Name 2") ]

        get '/api/v1/items/find?name=Thing+1'

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(item).to have_key(:data)
        expect(item[:data]).to be_an(Hash)
        expect(Item.all.count).to eq(4)
        expect(item.count).to eq(1)
        expect(item[:data][:attributes][:name]).to eq(items[0].name)
        item_response_checker(item[:data])
      end

      it "with name matching a search, case insensitive" do
        items =  [ create(:item, name: "Thing 1"),
                   create(:item, name: "Thing 2"),
                   create(:item, name: "Name 1"),
                   create(:item, name: "Name 2") ]

        get '/api/v1/items/find?NAME=THING+1'

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(item).to have_key(:data)
        expect(item[:data]).to be_an(Hash)
        expect(Item.all.count).to eq(4)
        expect(item.count).to eq(1)
        expect(item[:data][:attributes][:name]).to eq(items[0].name)
        item_response_checker(item[:data])
      end

      it "with name partially matching a search" do
        items =  [ create(:item, name: "Thing 1"),
                   create(:item, name: "Thing 2"),
                   create(:item, name: "Name 1"),
                   create(:item, name: "Name 2") ]

        get '/api/v1/items/find?name=ame'

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(item).to have_key(:data)
        expect(item[:data]).to be_an(Hash)
        expect(Item.all.count).to eq(4)
        expect(item.count).to eq(1)
        expect(item[:data][:attributes][:name]).to eq(items[2].name)
        item_response_checker(item[:data])
      end

      it "with name partially matching a search, case insensitive" do
        items =  [ create(:item, name: "Thing 1"),
                   create(:item, name: "Thing 2"),
                   create(:item, name: "Name 1"),
                   create(:item, name: "Name 2") ]

        get '/api/v1/items/find?name=aMe+1'

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(item).to have_key(:data)
        expect(item[:data]).to be_an(Hash)
        expect(Item.all.count).to eq(4)
        expect(item.count).to eq(1)
        expect(item[:data][:attributes][:name]).to eq(items[2].name)
        item_response_checker(item[:data])
      end

      it "with description matching a search" do
        items =  [ create(:item, description: "first cool item"),
                  create(:item, description: "second cool item"),
                  create(:item, description: "third cool item"),
                  create(:item, description: "meh") ]

        get '/api/v1/items/find?description=first+cool+item'

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(item).to have_key(:data)
        expect(item[:data]).to be_an(Hash)
        expect(Item.all.count).to eq(4)
        expect(item.count).to eq(1)
        expect(item[:data][:id]).to eq(items[0].id.to_s)
        item_response_checker(item[:data])
      end

      it "with description matching a search, case insensitive" do
        items =  [ create(:item, description: "first cool item"),
                  create(:item, description: "second cool item"),
                  create(:item, description: "third cool item"),
                  create(:item, description: "meh") ]

        get '/api/v1/items/find?description=SECOND+COOL+ITEM'

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(item).to have_key(:data)
        expect(item[:data]).to be_an(Hash)
        expect(Item.all.count).to eq(4)
        expect(item.count).to eq(1)
        expect(item[:data][:id]).to eq(items[1].id.to_s)
        item_response_checker(item[:data])
      end

      it "with description matching a partial search" do
        items =  [ create(:item, description: "first cool item"),
                  create(:item, description: "second cool item"),
                  create(:item, description: "third cool item"),
                  create(:item, description: "meh") ]

        get '/api/v1/items/find?description=first+cool'

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(item).to have_key(:data)
        expect(item[:data]).to be_an(Hash)
        expect(Item.all.count).to eq(4)
        expect(item.count).to eq(1)
        expect(item[:data][:id]).to eq(items[0].id.to_s)
        item_response_checker(item[:data])
      end

      it "with description matching a partial search, case insensitive" do
        items =  [ create(:item, description: "first cool item"),
                  create(:item, description: "second cool item"),
                  create(:item, description: "third cool item"),
                  create(:item, description: "meh") ]

        get '/api/v1/items/find?description=SECOND+COOL'

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(item).to have_key(:data)
        expect(item[:data]).to be_an(Hash)
        expect(Item.all.count).to eq(4)
        expect(item.count).to eq(1)
        expect(item[:data][:id]).to eq(items[1].id.to_s)
        item_response_checker(item[:data])
      end

      it "with created timestamp matching query" do
        items = [ create(:item, created_at: 'Wed, 16 Dec 2020'),
                  create(:item, created_at: 'Tue, 15 Dec 2020'),
                  create(:item, created_at: 'Wed, 16 Dec 2020'),
                  create(:item, created_at: 'Tue, 15 Dec 2020') ]

        get '/api/v1/items/find?created_at=December+16'

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(item).to have_key(:data)
        expect(item[:data]).to be_an(Hash)
        expect(Item.all.count).to eq(4)
        expect(item.count).to eq(1)
        expect(item[:data][:id]).to eq(items[0].id.to_s)
        item_response_checker(item[:data])
      end

      it "with created timestamp matching query, case insensitive" do
        items = [ create(:item, created_at: 'Wed, 16 Dec 2020'),
                  create(:item, created_at: 'Tue, 15 Dec 2020'),
                  create(:item, created_at: 'Wed, 16 Dec 2020'),
                  create(:item, created_at: 'Tue, 15 Dec 2020') ]

        get '/api/v1/items/find?created_at=DECEMBER+16'

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(item).to have_key(:data)
        expect(item[:data]).to be_an(Hash)
        expect(Item.all.count).to eq(4)
        expect(item.count).to eq(1)
        expect(item[:data][:id]).to eq(items[0].id.to_s)
        item_response_checker(item[:data])
      end

      it "with updated timestamp matching query" do
        items = [create(:item, updated_at: 'Wed, 16 Dec 2020'),
                  create(:item, created_at: 'Tue, 15 Dec 2020'),
                  create(:item, updated_at: 'Wed, 16 Dec 2020'),
                  create(:item, created_at: 'Tue, 15 Dec 2020')]

        get '/api/v1/items/find?updated_at=December+16'

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(item).to have_key(:data)
        expect(item[:data]).to be_an(Hash)
        expect(Item.all.count).to eq(4)
        expect(item.count).to eq(1)
        expect(item[:data][:id]).to eq(items[0].id.to_s)
        item_response_checker(item[:data])
      end

      it "with updated timestamp matching query, case insensitive" do
        items = [create(:item, updated_at: 'Wed, 16 Dec 2020'),
                  create(:item, created_at: 'Tue, 15 Dec 2020'),
                  create(:item, updated_at: 'Wed, 16 Dec 2020'),
                  create(:item, created_at: 'Tue, 15 Dec 2020')]

        get '/api/v1/items/find?updated_at=DECEMBER+16'

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(item).to have_key(:data)
        expect(item[:data]).to be_an(Hash)
        expect(Item.all.count).to eq(4)
        expect(item.count).to eq(1)
        expect(item[:data][:id]).to eq(items[0].id.to_s)
        item_response_checker(item[:data])
      end

      it "with unit price matching query" do
        items = [ create(:item, unit_price: 2.55),
                  create(:item, unit_price: 3.99),
                  create(:item, unit_price: 2.55),
                  create(:item, unit_price: 3.99) ]

        get '/api/v1/items/find?unit_price=3.99'

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(item).to have_key(:data)
        expect(item[:data]).to be_an(Hash)
        expect(Item.all.count).to eq(4)
        expect(item.count).to eq(1)
        expect(item[:data][:id]).to eq(items[1].id.to_s)
        item_response_checker(item[:data])
      end
    end
  end
end
