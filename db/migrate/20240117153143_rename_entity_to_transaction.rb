class RenameEntityToTransaction < ActiveRecord::Migration[7.1]
  def change
    rename_table :entities, :transactions
  end
end
