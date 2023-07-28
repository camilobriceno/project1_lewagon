class AddUserToFixedCosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :fixed_costs, :user, foreign_key: true
  end
end
