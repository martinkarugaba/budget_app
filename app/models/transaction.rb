class Transaction < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :categories

  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }

  def self.total_amount
    sum(:amount)
  end

  def self.recent
    order(created_at: :desc)
  end
end
