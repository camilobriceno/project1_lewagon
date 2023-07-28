class AddExpenseTypeToFixedCosts < ActiveRecord::Migration[7.0]
  def change
    add_column :fixed_costs, :expense_type, :string
  end
end
