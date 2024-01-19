class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :financial_transactions, class_name: 'Transaction'

  has_one_attached :icon

  validates :name, presence: true
  validates :name, format: { with: /\A[a-zA-Z0-9 ]+\z/ }
  validates :name, uniqueness: { scope: :user_id }
  validate :name_is_not_reserved

  def name_is_not_reserved
    errors.add(:name, 'is reserved') if name && %w[admin user guest].include?(name.downcase)
  end
end
