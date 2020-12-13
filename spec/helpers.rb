module Helpers
  def item_response_checker(item_data)
    expect(item_data).to have_key(:id)
    expect(item_data[:id]).to be_an(String)

    expect(item_data).to have_key(:type)
    expect(item_data[:type]).to be_an(String)
    expect(item_data[:type]).to eq("item")

    expect(item_data).to have_key(:attributes)
    expect(item_data[:attributes]).to be_a(Hash)

    expect(item_data[:attributes]).to have_key(:name)
    expect(item_data[:attributes][:name]).to be_an(String)

    expect(item_data[:attributes]).to have_key(:description)
    expect(item_data[:attributes][:description]).to be_an(String)

    expect(item_data[:attributes]).to have_key(:unit_price)
    expect(item_data[:attributes][:unit_price]).to be_an(Float)

    expect(item_data).to have_key(:relationships)
    expect(item_data[:relationships]).to be_a(Hash)

    expect(item_data[:relationships]).to have_key(:merchant)
    expect(item_data[:relationships][:merchant]).to be_a(Hash)

    expect(item_data[:relationships]).to have_key(:invoice_items)
    expect(item_data[:relationships][:invoice_items]).to be_a(Hash)

    expect(item_data[:relationships]).to have_key(:invoices)
    expect(item_data[:relationships][:invoices]).to be_a(Hash)

    expect(item_data[:relationships]).to have_key(:transactions)
    expect(item_data[:relationships][:transactions]).to be_a(Hash)
  end
end
