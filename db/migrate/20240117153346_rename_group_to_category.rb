class RenameGroupToCategory < ActiveRecord::Migration[7.1]
  def change
    rename_table :groups, :categories
  end
end
