class CreateJoinTableCategoryTransaction < ActiveRecord::Migration[7.1]
  def change
    create_join_table :categories, :transactions do |t|
      # t.index [:category_id, :transaction_id]
      # t.index [:transaction_id, :category_id]
    end
  end
end
