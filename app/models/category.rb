class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :financial_transactions, class_name: 'Transaction'

  has_one_attached :icon
end
