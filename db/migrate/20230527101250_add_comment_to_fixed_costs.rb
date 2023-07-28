class AddCommentToFixedCosts < ActiveRecord::Migration[7.0]
  def change
    add_column :fixed_costs, :comments, :text
  end
end
