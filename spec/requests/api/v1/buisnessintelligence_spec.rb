require 'rails_helper'

describe 'Buisness Intelligence Endpoints' do
  describe 'Merchants with Most Revenue' do
    before :each do
      @mer_1 = create :merchant
      @mer_2 = create :merchant
      @mer_3 = create :merchant
      @mer_4 = create :merchant
      @mer_5 = create :merchant
      @mer_6 = create :merchant
      @mer_7 = create :merchant
      @mer_8 = create :merchant

      @item_1 = create(:item, unit_price: 1.00, merchant: @mer_1)
      @item_2 = create(:item, unit_price: 1.00, merchant: @mer_2)
      @item_3 = create(:item, unit_price: 1.00, merchant: @mer_3)
      @item_4 = create(:item, unit_price: 1.00, merchant: @mer_4)
      @item_5 = create(:item, unit_price: 1.00, merchant: @mer_5)
      @item_6 = create(:item, unit_price: 1.00, merchant: @mer_6)
      @item_7 = create(:item, unit_price: 1.00, merchant: @mer_7)
      @item_8 = create(:item, unit_price: 0.01, merchant: @mer_8)


      @invoice_1 = create(:invoice, merchant: @mer_1, created_at: '2012-03-10')
      @invoice_2 = create(:invoice, merchant: @mer_2, created_at: '2012-03-10')
      @invoice_3 = create(:invoice, merchant: @mer_3, created_at: '2012-03-10')
      @invoice_4 = create(:invoice, merchant: @mer_4, created_at: '2012-03-10')
      @invoice_5 = create(:invoice, merchant: @mer_5, created_at: '2012-03-10')
      @invoice_6 = create(:invoice, merchant: @mer_6, created_at: '2012-03-10')
      @invoice_7 = create(:invoice, merchant: @mer_7, created_at: '2012-03-10', status: 'packaged')
      @invoice_8 = create(:invoice, merchant: @mer_8, created_at: '2012-03-10')

      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 5, unit_price: 1.00)
      @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 4, unit_price: 1.00)
      @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_3, quantity: 6, unit_price: 1.00)
      @invoice_item_4 = create(:invoice_item, item: @item_4, invoice: @invoice_4, quantity: 1, unit_price: 1.00)
      @invoice_item_5 = create(:invoice_item, item: @item_5, invoice: @invoice_5, quantity: 2, unit_price: 1.00)
      @invoice_item_6 = create(:invoice_item, item: @item_6, invoice: @invoice_6, quantity: 3, unit_price: 1.00)
      @invoice_item_7 = create(:invoice_item, item: @item_7, invoice: @invoice_7, quantity: 7, unit_price: 1.00)
      @invoice_item_8 = create(:invoice_item, item: @item_8, invoice: @invoice_8, quantity: 20, unit_price: 0.01)

      @transaction_1 = create(:transaction, invoice: @invoice_1)
      @transaction_2 = create(:transaction, invoice: @invoice_2)
      @transaction_3 = create(:transaction, invoice: @invoice_3)
      @transaction_4 = create(:transaction, invoice: @invoice_4)
      @transaction_5 = create(:transaction, invoice: @invoice_5)
      @transaction_6 = create(:transaction, invoice: @invoice_6)
      @transaction_7 = create(:transaction, invoice: @invoice_7, result: 'pending')
      @transaction_8 = create(:transaction, invoice: @invoice_8)
    end

    it "can return a variable number of merchants ranked by total revenue " do
      get '/api/v1/merchants/most_revenue?quantity=5'

       expect(response).to be_successful

       merchants = JSON.parse(response.body, symbolize_names: true)

       expect(response).to be_successful

       expect(merchants).to have_key(:data)
       expect(merchants[:data]).to be_an(Array)
       expect(Merchant.all.count).to eq(8)
       expect(merchants[:data].count).to eq(5)

       expected_ids_by_revenue = [@mer_3.id, @mer_1.id, @mer_2.id, @mer_6.id, @mer_5.id]
       resulting_ids_by_revenue = []
       merchants[:data].each do |merchant|
         merchant_response_checker(merchant)
         resulting_ids_by_revenue << merchant[:id].to_i
       end

       expect(resulting_ids_by_revenue).to eq(expected_ids_by_revenue)
    end

    it "can return a variable number of merchants ranked by total items sold" do
      get '/api/v1/merchants/most_items?quantity=2'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(merchants).to have_key(:data)
      expect(merchants[:data]).to be_an(Array)
      expect(Merchant.all.count).to eq(8)
      expect(merchants[:data].count).to eq(2)

      expected_ids_by_quantity_sold = [@mer_8.id, @mer_3.id]

      resulting_ids_by_quantity_sold = []
      merchants[:data].each do |merchant|
        merchant_response_checker(merchant)
        resulting_ids_by_quantity_sold << merchant[:id].to_i
      end

      expect(resulting_ids_by_quantity_sold).to eq(expected_ids_by_quantity_sold)
    end

    it "can return total revenue for a merchant" do
      get "/api/v1/merchants/#{@mer_3.id}/revenue"

      revenue = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(revenue).to have_key(:data)

      revenue_response_checker(revenue[:data])

      expect(revenue[:data][:attributes][:revenue]).to eq(6)
    end

    it "can return the total revenue across all merchants between the given dates" do
      get '/api/v1/revenue?start=2012-03-09&end=2012-03-24'

      revenue = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(revenue).to have_key(:data)

      revenue_response_checker(revenue[:data])

      expect(revenue[:data][:attributes][:revenue]).to eq(21.20)
    end
  end
end
