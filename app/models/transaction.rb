class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true, numericality: true
  validates_presence_of :result

  belongs_to :invoice
end
