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

      it "with names matching a search query, case insensitive" do
        merchant_names = ["Thing 1", "Thing 2", "Thing 3", "Name"]

        merchant_names.each do |name|
          create(:merchant, name: name)
        end

        get '/api/v1/merchants/find_all?name=ING'

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

      it "with created timestamps matching query, case insensitive" do
        merchant_1 = create(:merchant, created_at: 'Wed, 16 Dec 2020')
        merchant_2 = create(:merchant, created_at: 'Tue, 15 Dec 2020')
        merchant_3 = create(:merchant, created_at: 'Wed, 16 Dec 2020')
        merchant_4 = create(:merchant, created_at: 'Tue, 15 Dec 2020')

        get '/api/v1/merchants/find_all?created_at=DECEMBER+16'

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

      it "with updated timestamps matching query, case insensitive" do
        merchant_1 = create(:merchant, updated_at: 'Wed, 16 Dec 2020')
        merchant_2 = create(:merchant, updated_at: 'Tue, 15 Dec 2020')
        merchant_3 = create(:merchant, updated_at: 'Wed, 16 Dec 2020')
        merchant_4 = create(:merchant, updated_at: 'Tue, 15 Dec 2020')

        get '/api/v1/merchants/find_all?updated_at=DECEMBER+16'

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

      it "with name matching a search, case insensitive" do
        merchants =  [ create(:merchant, name: "Thing 1"),
                   create(:merchant, name: "Thing 2"),
                   create(:merchant, name: "Name 1"),
                   create(:merchant, name: "Name 2") ]

        get '/api/v1/merchants/find?name=AME'

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

        get '/api/v1/merchants/find?created_at=December+15'

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(merchant).to have_key(:data)
        expect(merchant[:data]).to be_an(Hash)
        expect(Merchant.all.count).to eq(4)
        expect(merchant.count).to eq(1)
        expect(merchant[:data][:id]).to eq(merchants[1].id.to_s)
        merchant_response_checker(merchant[:data])
      end

      it "with created timestamp matching query, case insensitive" do
        merchants = [ create(:merchant, created_at: 'Wed, 16 Dec 2020'),
                  create(:merchant, created_at: 'Tue, 15 Dec 2020'),
                  create(:merchant, created_at: 'Wed, 16 Dec 2020'),
                  create(:merchant, created_at: 'Tue, 15 Dec 2020') ]

        get '/api/v1/merchants/find?created_at=DECEMBER+15'

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(merchant).to have_key(:data)
        expect(merchant[:data]).to be_an(Hash)
        expect(Merchant.all.count).to eq(4)
        expect(merchant.count).to eq(1)
        expect(merchant[:data][:id]).to eq(merchants[1].id.to_s)
        merchant_response_checker(merchant[:data])
      end

      it "with updated timestamp matching query" do
        merchants = [create(:merchant, updated_at: 'Wed, 16 Dec 2020'),
                  create(:merchant, created_at: 'Tue, 16 Dec 2020'),
                  create(:merchant, updated_at: 'Wed, 15 Dec 2020'),
                  create(:merchant, created_at: 'Tue, 15 Dec 2020')]

        get '/api/v1/merchants/find?updated_at=December+15'

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(merchant).to have_key(:data)
        expect(merchant[:data]).to be_an(Hash)
        expect(Merchant.all.count).to eq(4)
        expect(merchant.count).to eq(1)
        expect(merchant[:data][:id]).to eq(merchants[2].id.to_s)
        merchant_response_checker(merchant[:data])
      end

      it "with updated timestamp matching query, case insensitive" do
        merchants = [create(:merchant, updated_at: 'Wed, 16 Dec 2020'),
                  create(:merchant, created_at: 'Tue, 16 Dec 2020'),
                  create(:merchant, updated_at: 'Wed, 15 Dec 2020'),
                  create(:merchant, created_at: 'Tue, 15 Dec 2020')]

        get '/api/v1/merchants/find?updated_at=DECEMBER+15'

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(merchant).to have_key(:data)
        expect(merchant[:data]).to be_an(Hash)
        expect(Merchant.all.count).to eq(4)
        expect(merchant.count).to eq(1)
        expect(merchant[:data][:id]).to eq(merchants[2].id.to_s)
        merchant_response_checker(merchant[:data])
      end
    end

    describe 'sad paths' do
      it 'responds with error if param value blank in single search' do

        get '/api/v1/merchants/find?name='

        error_message = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(error_message).to be_a(Hash)

        expect(error_message).to have_key(:error)
        expect(error_message[:error]).to eq('missing parameter')

        expect(error_message).to have_key(:errors)
        expect(error_message[:errors].first).to eq('search parameter with value required in search request')

        expect(error_message).to have_key(:status)
        expect(error_message[:status]).to eq('bad_request')
      end

      it 'responds with error if param undefined in single search' do

        get '/api/v1/merchants/find?'

        error_message = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(error_message).to be_a(Hash)

        expect(error_message).to have_key(:error)
        expect(error_message[:error]).to eq('missing parameter')

        expect(error_message).to have_key(:errors)
        expect(error_message[:errors].first).to eq('search parameter with value required in search request')

        expect(error_message).to have_key(:status)
        expect(error_message[:status]).to eq('bad_request')
      end

      it 'responds with error if param value blank in multi search' do

        get '/api/v1/merchants/find_all?name='

        error_message = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(error_message).to be_a(Hash)

        expect(error_message).to have_key(:error)
        expect(error_message[:error]).to eq('missing parameter')

        expect(error_message).to have_key(:errors)
        expect(error_message[:errors].first).to eq('search parameter with value required in search request')

        expect(error_message).to have_key(:status)
        expect(error_message[:status]).to eq('bad_request')
      end

      it 'responds with error if param undefined in multi search' do

        get '/api/v1/merchants/find_all?'

        error_message = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(error_message).to be_a(Hash)

        expect(error_message).to have_key(:error)
        expect(error_message[:error]).to eq('missing parameter')

        expect(error_message).to have_key(:errors)
        expect(error_message[:errors].first).to eq('search parameter with value required in search request')

        expect(error_message).to have_key(:status)
        expect(error_message[:status]).to eq('bad_request')
      end
    end
  end
end
