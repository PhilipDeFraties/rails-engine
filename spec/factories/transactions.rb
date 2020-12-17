FactoryBot.define do
  factory :transaction do
    association :invoice
    credit_card_number { Faker::Stripe.valid_card }
    credit_card_expiration_date { nil }
    result { 'success' }
  end
end
