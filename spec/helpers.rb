module Helpers
  def item_response_checker(item)
    expect(item).to have_key(:id)
    expect(item[:id]).to be_an(String)

    expect(item).to have_key(:type)
    expect(item[:type]).to be_an(String)
    expect(item[:type]).to eq("item")

    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_a(Hash)

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_an(String)

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_an(String)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_an(Float)

    expect(item).to have_key(:relationships)
    expect(item[:relationships]).to be_a(Hash)

    expect(item[:relationships]).to have_key(:merchant)
    expect(item[:relationships][:merchant]).to be_a(Hash)

    expect(item[:relationships]).to have_key(:invoice_items)
    expect(item[:relationships][:invoice_items]).to be_a(Hash)

    expect(item[:relationships]).to have_key(:invoices)
    expect(item[:relationships][:invoices]).to be_a(Hash)

    expect(item[:relationships]).to have_key(:transactions)
    expect(item[:relationships][:transactions]).to be_a(Hash)
  end
end
