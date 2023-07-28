class AddQuantityToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :quantity, :integer
  end
end
