class RemoveIconFromGroups < ActiveRecord::Migration[7.1]
  def change
    remove_column :groups, :icon, :string
  end
end
