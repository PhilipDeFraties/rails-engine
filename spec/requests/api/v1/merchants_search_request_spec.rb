require 'rails_helper'

describe "Merchants API" do
  describe 'Merchants search endpoints' do
    describe 'It can return a list of merchants' do
      it "with names matching a search query" do
        merchant_names = ["Thing 1", "Thing 2", "Thing 3", "Name"]

        merchant_names.each do |name|
          create(:merchant, name: name)
        end

        get '/api/v1/merchants/find_all?name=ing'

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(merchants).to have_key(:data)
        expect(merchants[:data]).to be_an(Array)
        expect(Merchant.all.count).to eq(4)
        expect(merchants[:data].count).to eq(3)

        merchants[:data].each do |merchant|
          merchant_response_checker(merchant)
        end
      end

      it "with created timestamps matching query" do
        merchant_1 = create(:merchant, created_at: 'Wed, 16 Dec 2020')
        merchant_2 = create(:merchant, created_at: 'Tue, 15 Dec 2020')
        merchant_3 = create(:merchant, created_at: 'Wed, 16 Dec 2020')
        merchant_4 = create(:merchant, created_at: 'Tue, 15 Dec 2020')

        get '/api/v1/merchants/find_all?created_at=December+16'

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(merchants).to have_key(:data)
        expect(merchants[:data]).to be_an(Array)
        expect(Merchant.all.count).to eq(4)
        expect(merchants[:data].count).to eq(2)

        merchants[:data].each do |merchant|
          merchant_response_checker(merchant)
        end
        expect(merchants[:data][0][:id]).to eq(merchant_1.id.to_s)
        expect(merchants[:data][1][:id]).to eq(merchant_3.id.to_s)
      end

      it "with updated timestamps matching query" do
        merchant_1 = create(:merchant, updated_at: 'Wed, 16 Dec 2020')
        merchant_2 = create(:merchant, updated_at: 'Tue, 15 Dec 2020')
        merchant_3 = create(:merchant, updated_at: 'Wed, 16 Dec 2020')
        merchant_4 = create(:merchant, updated_at: 'Tue, 15 Dec 2020')

        get '/api/v1/merchants/find_all?updated_at=December+16'

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(merchants).to have_key(:data)
        expect(merchants[:data]).to be_an(Array)
        expect(Merchant.all.count).to eq(4)
        expect(merchants[:data].count).to eq(2)

        merchants[:data].each do |merchant|
          merchant_response_checker(merchant)
        end
        expect(merchants[:data][0][:id]).to eq(merchant_1.id.to_s)
        expect(merchants[:data][1][:id]).to eq(merchant_3.id.to_s)
      end
    end

    describe "returns a single merchant" do
      it "with name matching a search" do
        merchants =  [ create(:merchant, name: "Thing 1"),
                   create(:merchant, name: "Thing 2"),
                   create(:merchant, name: "Name 1"),
                   create(:merchant, name: "Name 2") ]

        get '/api/v1/merchants/find?name=ame'

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(merchant).to have_key(:data)
        expect(merchant[:data]).to be_an(Hash)
        expect(Merchant.all.count).to eq(4)
        expect(merchant.count).to eq(1)
        expect(merchant[:data][:attributes][:name]).to eq(merchants[2].name)
        merchant_response_checker(merchant[:data])
      end

      it "with created timestamp matching query" do
        merchants = [ create(:merchant, created_at: 'Wed, 16 Dec 2020'),
                  create(:merchant, created_at: 'Tue, 15 Dec 2020'),
                  create(:merchant, created_at: 'Wed, 16 Dec 2020'),
                  create(:merchant, created_at: 'Tue, 15 Dec 2020') ]

        get '/api/v1/merchants/find?created_at=December+16'

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(merchant).to have_key(:data)
        expect(merchant[:data]).to be_an(Hash)
        expect(Merchant.all.count).to eq(4)
        expect(merchant.count).to eq(1)
        expect(merchant[:data][:id]).to eq(merchants[0].id.to_s)
        merchant_response_checker(merchant[:data])
      end

      it "with updated timestamp matching query" do
        merchants = [create(:merchant, updated_at: 'Wed, 16 Dec 2020'),
                  create(:merchant, created_at: 'Tue, 15 Dec 2020'),
                  create(:merchant, updated_at: 'Wed, 16 Dec 2020'),
                  create(:merchant, created_at: 'Tue, 15 Dec 2020')]

        get '/api/v1/merchants/find?updated_at=December+16'

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(merchant).to have_key(:data)
        expect(merchant[:data]).to be_an(Hash)
        expect(Merchant.all.count).to eq(4)
        expect(merchant.count).to eq(1)
        expect(merchant[:data][:id]).to eq(merchants[0].id.to_s)
        merchant_response_checker(merchant[:data])
      end
    end
  end
end
