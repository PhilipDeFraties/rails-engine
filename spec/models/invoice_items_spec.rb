require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
  end

  describe 'relationships' do
    it { should belong_to :item }
    it { should belong_to :invoice }
    it { should have_many :transactions }
  end

  describe 'class methods' do
    before :each do
      @mer_1 = create :merchant
      @mer_2 = create :merchant
      @mer_3 = create :merchant
      @mer_4 = create :merchant
      @mer_5 = create :merchant
      @mer_6 = create :merchant
      @mer_7 = create :merchant
      @mer_8 = create :merchant
      @mer_9 = create :merchant

      @item_1 = create(:item, unit_price: 1.00, merchant: @mer_1)
      @item_2 = create(:item, unit_price: 1.00, merchant: @mer_2)
      @item_3 = create(:item, unit_price: 1.00, merchant: @mer_3)
      @item_4 = create(:item, unit_price: 1.00, merchant: @mer_4)
      @item_5 = create(:item, unit_price: 1.00, merchant: @mer_5)
      @item_6 = create(:item, unit_price: 1.00, merchant: @mer_6)
      @item_7 = create(:item, unit_price: 1.00, merchant: @mer_7)
      @item_8 = create(:item, unit_price: 0.01, merchant: @mer_8)
      @item_9 = create(:item, unit_price: 1.00, merchant: @mer_9)


      @invoice_1 = create(:invoice, merchant: @mer_1, created_at: '2012-03-10')
      @invoice_2 = create(:invoice, merchant: @mer_2, created_at: '2012-03-10')
      @invoice_3 = create(:invoice, merchant: @mer_3, created_at: '2012-03-10')
      @invoice_4 = create(:invoice, merchant: @mer_4, created_at: '2012-03-10')
      @invoice_5 = create(:invoice, merchant: @mer_5, created_at: '2012-03-10')
      @invoice_6 = create(:invoice, merchant: @mer_6, created_at: '2012-03-10')
      @invoice_7 = create(:invoice, merchant: @mer_7, created_at: '2012-03-10', status: 'packaged')
      @invoice_8 = create(:invoice, merchant: @mer_8, created_at: '2012-03-10')
      @invoice_9 = create(:invoice, merchant: @mer_9, created_at: '2012-03-10')

      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 5, unit_price: 1.00)
      @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 4, unit_price: 1.00)
      @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_3, quantity: 6, unit_price: 1.00)
      @invoice_item_4 = create(:invoice_item, item: @item_4, invoice: @invoice_4, quantity: 1, unit_price: 1.00)
      @invoice_item_5 = create(:invoice_item, item: @item_5, invoice: @invoice_5, quantity: 2, unit_price: 1.00)
      @invoice_item_6 = create(:invoice_item, item: @item_6, invoice: @invoice_6, quantity: 3, unit_price: 1.00)
      @invoice_item_7 = create(:invoice_item, item: @item_7, invoice: @invoice_7, quantity: 7, unit_price: 1.00)
      @invoice_item_8 = create(:invoice_item, item: @item_8, invoice: @invoice_8, quantity: 20, unit_price: 0.01)
      @invoice_item_9 = create(:invoice_item, item: @item_9, invoice: @invoice_9, quantity: 10, unit_price: 1.00)


      @transaction_1 = create(:transaction, invoice: @invoice_1)
      @transaction_2 = create(:transaction, invoice: @invoice_2)
      @transaction_3 = create(:transaction, invoice: @invoice_3)
      @transaction_4 = create(:transaction, invoice: @invoice_4)
      @transaction_5 = create(:transaction, invoice: @invoice_5)
      @transaction_6 = create(:transaction, invoice: @invoice_6)
      @transaction_7 = create(:transaction, invoice: @invoice_7)
      @transaction_8 = create(:transaction, invoice: @invoice_8)
      @transaction_9 = create(:transaction, invoice: @invoice_9, result: 'failed')
    end

    it "#revenue_accross_dates" do
      expect(InvoiceItem.revenue_across_dates('2012-03-09', '2012-03-24')).to eq(21.2)
      # does not include revenue in calculation if transaction result unsuccessful or invoice status unshipped
      @transaction_9.update(result: 'success')
      @invoice_7.update(status: 'shipped')
      expect(InvoiceItem.revenue_across_dates('2012-03-09', '2012-03-24')).to eq(38.2)
    end
  end
end
